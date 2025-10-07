# Cart

An example implementation of cart functionality with usage of Swift, UIKit & RxSwift.
It also contains a simple dependency injection solution and backend mock engine.

## Requirements

1. XCode 26.0.1
2. Swift 6.2
3. Cocoapods 1.16.2
4. RxSwift 6.5.0
5. RxCocoa 6.5.0
6. iOS 26.0

## Setup & Running

App is configured with no code signing (no team) with automatic signing management disabled.
Signing would be required to set-up when targetting test devices. But with provided setup, it can safely run in iOS simulator.

To run project follow steps below:
1. In terminal, fom the root repository directory run `pod install`
2. In terminal, from the root respository directory run `open CartExercise.xcworkspace` or open workspace in XCode manually
3. In XCode, select simulator device and press `run` to run the project in the simulator

## Structure: Modules

Project is divided into bunch of modules to separate code by layers and purpose (scope).
Some of the frameworks are utilities like a simple dependency injection container solution, backend app simulator, and http client intermediate layer. This app is not using any networking, but to simulate communication with backend app, a small backend simulator engine runs the app that simualtes api functionalities.

### NetworkingCore

This module is first core utility module to define basic types related to Http like requests, responses, status codes. These core types are then used in both client and "backend" frameworks.

### DependencyInjection

Simple implementation of dependency container that allows to register dependencies in the container as factories, lazy singletons and singletos. The dependencies can then be resolved or even injected into class properties by using `@Inject(strategy)` property wrapper.
In order to use `@Inject` property wrapper, the enclosing instance has to be a class in order for subscripts to be called correctly.

`@Inject` supports 4 different strategies of injecting dependencies
- default - uses default global container to resolve dependencies
- fixed - uses fixed, provided, container for resolving dependencies
- dynamic - uses provider function to provide container for resolving dependencies
- enclosingInstance - uses enclosing instance's `diContainer` property as container for resolving dependencies. In order for this strategy to work, enclosing instance has to be a class and implement `PHasDIContaner` protocol.

Apart from that, first 3 strategies allows for immediate or lazy dependeny injection. Enclosing instance mode always uses lazy injection.

This package is intensively used in other modules to manage dependencies.

### BackendCore

Contains small on-device backend-simulator engine for http servers (note: it doesn't run real http server, its just simulation layer). It allows to create and run apps that support routing requests by url and method to controllers/handler functions. Apart from this backend engine allows to set up services, repositories and other dependencies to be injected to controllers by using internal depedency injection container.
The purpose of this engine is to simulate backend apps on device so that arbitrary data can be passed around and coded/decoded. App supports middlewares that can be added to the simulation to be executed in registration order for every request made to the app. By utilizing it the example can showcase real separation of responsibilites between client app and backend app, in a friendly, self-contained manner.

### HttpClient

Simple http client abstraction layer with consists of few elements.

1. HttpClient - orchestrates http requests calls with helper functions like `get`, `post`, `delete` etc.
2. RestAPIClient - Extends HttpClient with support for basic request/response models (encodable/decodable) to be sent via `get`, `post` (etc.) methods.
3. Interceptors - interceptors can be attached to http client and their function are run in registration order to first prepare (modify, like adding default headers) request before actually sending it, and then process response/error before it is passed to the caller.
4. HttpRequester - it's actually a protocol abstraction to be implemented by end-app. It's role is to perform actuall HTTP request to the API. An example requester might be implemented by calling, for example, alamofire to send the data. In the project in the actual app example module, there is requester defined that simply calls the handle function of backend app simulator instance instead of sending packets via network.

### CartCore

Core abstraction & data layers for cart example. It contains services protocols for all example functionalities along with all required data models. These data types are used by both cart-backend-simulated app, and mobile client app. Backend implements their own versions of services used by controllers, while mobile app uses sdk that implements and extends these services with client-friendly features like reactive extensions.

Currently 3 services with following functionalities are defined:
- CartService
    - getting cart
    - adding items to cart
    - removing items from cart
    - clearing cart
- CurrenciesService:
    - getting available currencies
    - getting conversion rates for currencies like USD->EUR, EUR->USD etc.
- OffersService
    - getting all offers
    - getting offers with specified ids
    - getting offer details

### CartSDK

SDK that implements and extends services from CartCore to be used in client apps. Internally these service implementations just calls http clients to perform "network" request. It could send it via real network if injected with requester that does so, but for purpose of the example project, the requester calls backend-simulation engine on the same app process.
The services and their protocols are extended with reactive functionalities like e.g. holding currently picked currency, current cart state, local cart state prediction for preview before api call is made (then after processing api call the cart is refreshed with really modififed cart)
It also contains utility sdk class that registers all dependencies into provided dependency injection container.

### CartBackendMock

Simple backend simulated API for cart functionality. It implements backend versions of CartCore services.
Each module (cart, currencies, offers) is divided into 3 layers:
- controller - registers routers and handles requests made to the app by calling service (could do additional thing like check authentication etc.)
- service - actual backend business logic resides here, it can call other services or repositories
- repository - Used as data source and data store, in this example app repository is usually a simple in-memory data structure like dictionary. It also handles initial data loading. On real backend app this layer might call for example a database
- app factory function - it uses builder to setup all repositories, services and controllers along with encoders/decoders. It also loads backend configuration. In real, life apart from that, it would register middlewares for handling authorization, automatic responses, error handling, rate limitting etc.

### CartExercise

End-product of an cart functionality example. It's a mobile app project that embedds all functionalities from rest of the modules and executes them. It is divided in a few scopes.

- Styling - containing app styling support for consistent colors and fonts constants
- Networking - implements simple BackendRequester that calls backend app (simulated in the app process) to handle the request. In real life it could call alamofire to do real api calls.
- Core - core & common functionalities, like empty views, app initializer, basic protocols, view factories, useful extensions etc. (antything that's core and common)
- Features - contains encapsulated features directories, one for each feature in the app

Implemented features
1. App - contains app root view controller, whole app is based on this single root controller (its embedded inside)
2. Navigation - contains standarized navigation to be used in different parts of the project
3. Home - main functionality of an app. It's a tab bar embedding 2 other features: shop & cart
4. Shop - contains code supporting offers feed in shop functionality, allows viewing items and quickly adding them to cart or opening offer details
5. OfferDetails - implementation of offer details, where user can view full offer info and add to cart in larger quantities
6. Cart - cart details feature, it lists every item in the cart. Allows clearing cart, changing quantities of items, removing items from cart. It also allows to change cart currency to view cart in different currencies (Note: base, fixed cart currency in the system is USD, any other currency is derived). It allows proceeding to checkout. It also supports different view for empty cart or a view while cart is loading.
7. Checkout - consits of checkout summary view and purchase result view. Checkout summary view displays summary created from cart state, with information of whats user trying to purchase. Its an read-only screen, the only thing user can do is preview in different currencies or proceed. After proceeding the cart is cleared and user is transferred to purchase result screen, from which he can go back to cart (which is now empty)
8. CurrencyPicker - implementation of currency picker (by utilizing UIPickerView) used in Cart & Checkout features. It displays available currencies (with current preselected) and allows to pick one.

Each feature consists of a few movable parts
1. Views - basic building block for displaying data, usually styled with injected view factories and style
2. Cells - cells to be used in collection / table views
3. View Controllers - binds view model data to view, and view action back to view model / coordinator
4. View Models - provides data for the views, also handles simple interactions, sometimes calling coordinator
5. Coordinators - implements navigation (pushing, poping, presenting, dismissing, embdding etc.)
6. Module builders - their role is to construct and return ready and set-up view controller for given module


### Naming conventions

One can see that every protocol is prefixed with `P` like `PCoordinator`. It is done so to easily distinguish protocols in the codebase and provides no other benefit.


## What could be done?

I think full checkout flow would be a nice thing.
It could involve yet another service like `CheckoutService` `PurchaseService` or `OrdersService`, that would provide funcionalities like creating `Order` from current cart state or single item for quick buy. Such order would have multiple states (stages) like intial, summary, address, payment, purchased, possibly preparing_order, delivery, delivered, cancelled etc.
Currently the mobile app creates summary of a cart view and proceeds to checkout. It would all this `OrdersService` instead and it would return an order with initial state. Then the flow could go to address & delivery address collecting, payment method selection, simulating payment process, displaying pruchase result etc.
Currenty mobile app triggers clearing-up cart when user clicks "proceed" button. If this service is implemented, it would be actually backend's `OrderService` that clears the cart associated to the order after finishing the payment step. Mobile app would just need to refresh cart, which would be empty now. It would be much cleaner, and logic would be in the right place.

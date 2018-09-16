Microservice Kubernetes Sample
=====================

This demo uses [Kubernetes](https://kubernetes.io/) as Docker
environment. Kubernetes also support service discovery and load
balancing. An Apache httpd as a reverse proxy routes the calls to the
services.

This project creates a complete micro service demo system in Docker
containers. The services are implemented in Java using Spring and
Spring Cloud.

It uses three microservices:
- `Order` to process orders.
- `Customer` to handle customer data.
- `Catalog` to handle the items in the catalog.


Apache HTTP Load Balancer
------------------------

Apache HTTP is used to provide the web page of the demo at
port 8080. It also forwards HTTP requests to the microservices.

Apache HTTP is configured as a reverse proxy for this.
Load balancing is left to Kubernetes.

To configure this Apache HTTP needs to get all registered services from
Kubernetes. It just uses DNS for that.


Remarks on the Code
-------------------

The microservices are:

- [microservice-kubernetes-demo-catalog](microservice-kubernetes-demo/microservice-kubernetes-demo-catalog) is the application to take care of items.
- [microservice-kubernetes-demo-customer](microservice-kubernetes-demo/microservice-kubernetes-demo-customer) is responsible for customers.
- [microservice-kubernetes-demo-order](microservice-kubernetes-demo/microservice-kubernetes-demo-order) does order processing. It uses
  microservice-kubernetes-demo-catalog and microservice-kubernetes-demo-customer.
  Hystrix is used for resilience.

The microservices use REST to communicate to each other.
See e.g. [CatalogClient](microservice-kubernetes-demo/microservice-kubernetes-demo-order/src/main/java/com/ewolff/microservice/order/clients/CatalogClient.java) .
The hostname is configurable to allow tests with stubs.
The default is `catalog` which works with Kubernetes.
Other microservices are found using Kubernetes built-in DNS.
Kubernetes does the load balancing on the IP level.

The microservices have a Java main application in `src/test/java` to
run them stand alone. `microservice-demo-order` uses a stub for the
other services then. Also there are tests that use _consumer-driven
contracts_. That is why it is ensured that the services provide the
correct interface. These CDC tests are used in microservice-demo-order
to verify the stubs. In `microservice-kubernetes-demo-customer` and
`microserivce-kubernetes-demo-catalog` they are used to verify the implemented
REST services.

Note that the code has no dependencies on Kubernetes. Only Spring
Cloud Hystrix is used to add resilience.

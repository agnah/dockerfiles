====
Development Dockerfiles
====


----
System requirements
----

* Docker
* Docker Compose
* Clone of required repositories:

    * tickets-api
    * tickets-admin
    * Others...

----
Environment requirements
----

You need to clone **all** the projects repositories that require it on your local host, then you need to build the docker image for **each** of the projects.

**For example, if we were doing this for the tickets-api project:**

.. code-block:: bash

    ~/src/tickets-api$ ./scripts/build.sh

----
Tickets database requirements
----

* Enter the mysql container and login into a mysql terminal:


.. code-block:: bash

   $ docker-compose up -d mysql-service
   $ docker exec -ti dockerfiles_mysql-service_1 bash
   root@aaabbbcccdd:/# mysql -u root -p


* Create the necessary databases

.. code-block:: sql

   CREATE DATABASE tickets;


* Grant all privileges to `default` user


.. code-block:: sql

   GRANT ALL PRIVILEGES ON tickets.* to 'default'@'%';
   FLUSH PRIVILEGES;
   exit;


* Dump the databases into mysql

.. code-block:: bash

   root@aaabbbcccdd:/# cd docker-entrypoint-initdb.d/
   root@aaabbbcccdd:/# mysql -u root -p tickets < mysql-academia.sql

----
Install hosts
----

Install hosts maps in your system:

.. code-block:: bash

    $ sudo ./install-hosts.sh



----
Start development environment
----

Once you built the images for all the required services (Please see docker-compose.yml ``services``), you can start the environment

.. code-block:: bash

    $ docker-compose up -d


----
Attach to a container's logs
----

Sometimes during development we'd like to see the output of the service's logs, to do so, we can attach a terminal to follow the container's stdout logs

For example, to attach to Ticket's logs:

.. code-block:: bash

    $ docker logs $(docker ps -aqf "name=tickets") -f

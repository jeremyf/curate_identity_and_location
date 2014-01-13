# Curate Identity And Location

## Why are we creating a separate application from Curate?

* We need a faster environment to explore a few complicated use cases.
* The existing application will be very painful and time consuming to work in.
* We don't actually need much of the cruft that is found in Curate.
* The current deposit behavior of Curate is naive and simultaneously rigid.
  * Objects are immediately ingested into Fedora.
  * Installable/configurable options are more challenging in the current ecosystem.
* We should practice how we can design the application as a team.
  * This will involve writing fast test
* We can extract much of this behavior and put it back into a shared IR
* Curate's initial parameters, as I understood them, are significantly smaller than the current parameters
* We have lots of "new to Rails and Ruby" developers
  * I believe collaborating on a well defined scope will help build confidence and understanding
* The namespacing in Curate is a bloody mess
* The seams of Curate configuration is not immediately obvious
* We may not require Fedora & Solr for much of this

## What is this application about?

* **Deposit:** a Form object for a Location, requested by an Identity, of a specific WorkType
* **Form:** an object instantiated by a controller; It is responsible for exposing attributes, validations, and invoking the service object (i.e. the #new action renders the attributes for input, the #create action assigns the attributes, validates, and then saves the content via the injected service object)
* **Identity:** a permanently referencable object that has members. Is eligible for IdentityMembership.
* **IdentityMembership:** A triple of [Identity, IdentityMember, IdentityMembershipRole].
* **IdentityMembershipRole:** :administrator, :member; In essence what actions can they take.
* **Location:** a place in which AcademicWorks are deposited, mediated, and ingested.
* **Service:** an object responsible for processing a form object's attributes (i.e. persist the user input to the database)
* **User:** a person/agent that is authenticated with the application. Is eligible for IdentityMembership.
* **Work:** an instantiation of a particular WorkType; it is a bucket for both metadata and artifacts
* **WorkType:** The classification of a Work (i.e. Document, ETD, etc.)

## Deposit behavior

Below is the proposed behavior for a deposit:

    class DepositsController
      def new
        deposit
        authorize_action!
        assign_deposit_attributes
        respond_with_deposit
      end

      def create
        deposit
        authorize_action!
        assign_deposit_attributes
        save_deposit
        respond_with
      end

      protected
      def deposit
        return @deposit if @deposit
        location = determine_location
        identity = determine_identity
        work_type = determine_work_type
        @deposit = location.build_new_deposit(identity: identity, work_type: work_type)
      end

      def authorize_action!
        # can the current user do what they are trying to do;
        # it is possible the instantiate_deposit method will raise exceptions
        # when authorization does not work
      end

      def assign_deposit_attributes
        deposit.attributes = params[:deposit]
      end

      def save_deposit
        # By providing this block, we are allowing a successful save of the form
        # to yield and pass the work on; This keeps the focus of the form very
        # tight and provides a way to have the attributes and validation vary
        # as well as the "what happens when succesful" behavior
        deposit.save {|dep| new_deposit_service.call(self, dep) }
      end

      def respond_with_deposit
        # A custom Rails responder could be added to the application. This
        # in turn would control where to redirect; whether messages are flashed.
        respond_with(deposit)
      end

    end
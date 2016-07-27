package Mail::Chimp3;

use Moo;
use strictures 2;
use namespace::autoclean;
use Types::Standard qw/ Num Str /;

with 'Web::API';

# ABSTRACT: An interface to mailchimp.com's RESTful Web API v3 using WEB::API

# VERSION: generated by DZP::OurPkgVersion

=head1 SYNOPSIS

This is for the MailChimp API v3.0.

Please refer to the API documentation at 
L<http://developer.mailchimp.com/documentation/mailchimp/reference/overview/>

    use Mail::Chimp3;

    my $mailchimp = Mail::Chimp3->new(
        api_key => $apikey,
    );

    my $response = $mailchimp->add_store(
        store_id => '123',
        cart_id  => '456',
    );

=head1 METHODS

=over

=item add_authorized_app

=item add_automation_subscriber

=item add_batch

=item add_cart

=item add_cart_line

=item add_customer

=item add_list

=item add_member

=item add_merge_field

=item add_order

=item add_order_line

=item add_product

=item add_segment

=item add_store

=item add_variant

=item authorized_app

=item authorized_apps

=item automation

=item automation_email

=item automation_emails

=item automations

=item automation_subscriber

=item automation_subscribers

=item batch

=item batches

=item cart

=item cart_line

=item cart_lines

=item carts

=item conversation

=item conversations

=item customer

=item customers

=item delete_batch

=item delete_cart

=item delete_cart_line

=item delete_customer

=item delete_list

=item delete_member

=item delete_merge_field

=item delete_order

=item delete_order_line

=item delete_product

=item delete_segment

=item delete_store

=item delete_variant

=item list

=item lists

=item member

=item members

=item merge_field

=item merge_fields

=item order

=item order_line

=item order_lines

=item orders

=item pause_automation

=item pause_automation_email

=item product

=item products

=item remove_automation_subscriber

=item removed_automation_subscribers

=item root

=item segment

=item segments

=item start_automation

=item start_automation_email

=item store

=item stores

=item update_cart

=item update_cart_line

=item update_customer

=item update_list

=item update_member

=item update_merge_field

=item update_order

=item update_order_line

=item update_segment

=item update_store

=item update_variant

=item upsert_customer

=item upsert_member

=item upsert_variant

=item variant

=item variants

=back

=cut

has 'endpoints' => (
    is      => 'rw',
    default => sub {
        {
            root => { path => '/' },

            # authorized apps
            authorized_app     => { path => 'authorized-apps/:app_id' },
            authorized_apps    => { path => 'authorized-apps' },
            add_authorized_app => {
                method    => 'POST',
                path      => 'authorized-apps',
                mandatory => [ 'client_id', 'client_secret', ],
            },

            # automations
            automation       => { path => 'automations/:workflow_id' },
            automations      => { path => 'automations' },
            pause_automation => {
                method => 'POST',
                path   => 'automations/:workflow_id/actions/pause-all-emails',
            },
            start_automation => {
                method => 'POST',
                path   => 'automations/:workflow_id/actions/start-all-emails',
            },

            # automation emails
            automation_email       => { path => 'automations/:workflow_id/emails/:workflow_email_id' },
            automation_emails      => { path => 'automations/:workflow_id/emails' },
            pause_automation_email => {
                method => 'POST',
                path   => 'automations/:workflow_id/emails/:workflow_email_id/actions/pause',
            },
            start_automation_email => {
                method => 'POST',
                path   => 'automations/:workflow_id/emails/:workflow_email_id/actions/start',
            },
            add_automation_subscriber => {
                method    => 'POST',
                path      => 'automations/:workflow_id/emails/:workflow_email_id/queue',
                mandatory => ['email_address'],
            },
            automation_subscriber => {
                path => 'automations/:workflow_id/emails/:workflow_email_id/queue/:subscriber_hash',
            },
            automation_subscribers => {
                path => 'automations/:workflow_id/emails/:workflow_email_id/queue',
            },
            remove_automation_subscriber => {
                method    => 'POST',
                path      => 'automations/:workflow_id/removed-subscribers',
                mandatory => ['email_address'],
            },
            removed_automation_subscribers => { path => 'automations/:workflow_id/removed-subscribers' },

            # batch
            batch     => { path => 'batches/:batch_id' },
            batches   => { path => 'batches' },
            add_batch => {
                method    => 'POST',
                path      => 'batches',
                mandatory => ['operations'],
            },
            delete_batch => {
                method => 'DELETE',
                path   => 'batches/:batch_id',
            },

            # campaign folders
            # TODO

            # campaigns
            # TODO

            # conversations
            # TODO
            conversation  => { path => 'conversations/:conversation_id' },
            conversations => { path => 'conversations' },

            # ecommerce stores
            store     => { path => 'ecommerce/stores/:store_id' },
            stores    => { path => 'ecommerce/stores' },
            add_store => {
                method    => 'POST',
                path      => 'ecommerce/stores',
                mandatory => [ 'id', 'list_id', 'name', 'currency_code', ],
            },
            update_store => {
                method => 'PATCH',
                path   => 'ecommerce/stores/:store_id',
            },
            delete_store => {
                method => 'DELETE',
                path   => 'ecommerce/stores/:store_id',
            },

            # ecommerce carts
            cart     => { path => 'ecommerce/stores/:store_id/carts/:cart_id' },
            carts    => { path => 'ecommerce/stores/:store_id/carts' },
            add_cart => {
                method    => 'POST',
                path      => 'ecommerce/stores/:store_id/carts',
                mandatory => ['customer'],
            },
            update_cart => {
                method => 'PATCH',
                path   => 'ecommerce/stores/:store_id/carts/:cart_id',
            },
            delete_cart => {
                method => 'DELETE',
                path   => 'ecommerce/stores/:store_id/carts/:cart_id',
            },

            # ecommerce cart lines
            cart_line     => { path => 'ecommerce/stores/:store_id/carts/:cart_id/lines/:line_id' },
            cart_lines    => { path => 'ecommerce/stores/:store_id/carts/:cart_id/lines' },
            add_cart_line => {
                method    => 'POST',
                path      => 'ecommerce/stores/:store_id/carts/:cart_id/lines',
                mandatory => [
                    qw/
                        id
                        product_id
                        product_variant_id
                        quantity
                        price
                        /
                ],
            },
            update_cart_line => {
                method => 'PATCH',
                path   => 'ecommerce/stores/:store_id/carts/:cart_id/lines/:line_id',
            },
            delete_cart_line => {
                method => 'DELETE',
                path   => 'ecommerce/stores/:store_id/carts/:cart_id/lines/:line_id',
            },

            # ecommerce customers
            customer     => { path => 'ecommerce/stores/:store_id/customers/:customer_id' },
            customers    => { path => 'ecommerce/stores/:store_id/customers' },
            add_customer => {
                method    => 'POST',
                path      => 'ecommerce/stores/:store_id/customers',
                mandatory => [
                    qw/
                        id
                        email_address
                        opt_in_status
                        /
                ],
            },
            update_customer => {
                method => 'PATCH',
                path   => 'ecommerce/stores/:store_id/customers/:customer_id',
            },
            upsert_customer => {
                method    => 'PUT',
                path      => 'ecommerce/stores/:store_id/customers/:customer_id',
                mandatory => [
                    qw/
                        id
                        email_address
                        opt_in_status
                        /
                ],
            },
            delete_customer => {
                method => 'DELETE',
                path   => 'ecommerce/stores/:store_id/customers/:customer_id',
            },

            # ecommerce orders
            order     => { path => 'ecommerce/stores/:store_id/orders/:order_id' },
            orders    => { path => 'ecommerce/stores/:store_id/orders' },
            add_order => {
                method    => 'POST',
                path      => 'ecommerce/stores/:store_id/orders',
                mandatory => [
                    qw/
                        id
                        customer
                        currency_code
                        order_total
                        lines
                        /
                ],
            },
            update_order => {
                method => 'PATCH',
                path   => 'ecommerce/stores/:store_id/orders/:order_id',
            },
            delete_order => {
                method => 'DELETE',
                path   => 'ecommerce/stores/:store_id/orders/:order_id',
            },

            # ecommerce order lines
            order_line     => { path => 'ecommerce/stores/:store_id/orders/:order_id/lines/:line_id' },
            order_lines    => { path => 'ecommerce/stores/:store_id/orders/:order_id/lines' },
            add_order_line => {
                method    => 'POST',
                path      => 'ecommerce/stores/:store_id/orders/:order_id/lines',
                mandatory => [
                    qw/
                        id
                        product_id
                        product_variant_id
                        quantity
                        price
                        /
                ],
            },
            update_order_line => {
                method => 'PATCH',
                path   => 'ecommerce/stores/:store_id/orders/:order_id/lines/:line_id',
            },
            delete_order_line => {
                method => 'DELETE',
                path   => 'ecommerce/stores/:store_id/orders/:order_id/lines/:line_id',
            },

            # ecommerce products
            product     => { path => 'ecommerce/stores/:store_id/products/:product_id' },
            products    => { path => 'ecommerce/stores/:store_id/products' },
            add_product => {
                method    => 'POST',
                path      => 'ecommerce/stores/:store_id/products',
                mandatory => [ 'id', 'title', 'variants', ],
            },
            delete_product => {
                method => 'DELETE',
                path   => 'ecommerce/stores/:store_id/products/:product_id',
            },

            # ecommerce product variants
            variant     => { path => 'ecommerce/stores/:store_id/products/:product_id/variants/:variant_id' },
            variants    => { path => 'ecommerce/stores/:store_id/products/:product_id/variants' },
            add_variant => {
                method    => 'POST',
                path      => 'ecommerce/stores/:store_id/products/:product_id/variants',
                mandatory => [ 'id', 'title', ],
            },
            update_variant => {
                method => 'PATCH',
                path   => 'ecommerce/stores/:store_id/products/:product_id/variants/:variant_id',
            },
            upsert_variant => {
                method    => 'PUT',
                path      => 'ecommerce/stores/:store_id/products/:product_id/variants/:variant_id',
                mandatory => [ 'id', 'title', ],
            },
            delete_variant => {
                method => 'DELETE',
                path   => 'ecommerce/stores/:store_id/products/:product_id/variants/:variant_id',
            },

            # file manager files
            #TODO

            # file manager folders
            #TODO

            # lists
            # TODO
            list     => { path => 'lists/:list_id' },
            lists    => { path => 'lists' },
            add_list => {
                method    => 'POST',
                path      => 'lists',
                mandatory => [
                    qw/
                        name
                        contact
                        permission_reminder
                        campaign_defaults
                        email_type_option
                        /
                ],
            },
            update_list => {
                method    => 'PATCH',
                path      => 'lists/:list_id',
                mandatory => [
                    qw/
                        name
                        contact
                        permission_reminder
                        campaign_defaults
                        email_type_option
                        /
                ],
            },
            delete_list => {
                method => 'DELETE',
                path   => 'lists/:list_id',
            },

            # list members
            member     => { path => 'lists/:list_id/members/:subscriber_hash' },
            members    => { path => 'lists/:list_id/members' },
            add_member => {
                method    => 'POST',
                path      => 'lists/:list_id/members',
                mandatory => [ 'status', 'email_address', ],
            },
            update_member => {
                method => 'PATCH',
                path   => 'lists/:list_id/members/:subscriber_hash',
            },
            upsert_member => {
                method    => 'PUT',
                path      => 'lists/:list_id/members/:subscriber_hash',
                mandatory => [
                    qw/
                        email_address
                        status_if_new
                        /
                ],
            },
            delete_member => {
                method => 'DELETE',
                path   => 'lists/:list_id/members/:subscriber_hash',
            },

            # merge fields
            merge_field     => { path => 'lists/:list_id/merge-fields/:merge_id' },
            merge_fields    => { path => 'lists/:list_id/merge-fields' },
            add_merge_field => {
                method    => 'POST',
                path      => 'lists/:list_id/merge-fields',
                mandatory => [ 'name', 'type', ],
            },
            update_merge_field => {
                method => 'PATCH',
                path   => 'lists/:list_id/merge-fields/:merge_id',
            },
            delete_merge_field => {
                method => 'DELETE',
                path   => 'lists/:list_id/merge-fields/:merge_id',
            },

            # segments
            segment     => { path => 'lists/:list_id/segments/:segment_id' },
            segments    => { path => 'lists/:list_id/segments' },
            add_segment => {
                method    => 'POST',
                path      => 'lists/:list_id/segments',
                mandatory => ['name'],
            },
            update_segment => {
                method => 'PATCH',
                path   => 'lists/:list_id/segments/:segment_id',
            },
            delete_segment => {
                method => 'DELETE',
                path   => 'lists/:list_id/segments/:segment_id',
            },

            # reports
            #TODO

            # template folders
            #TODO

            # templates
            #TODO
        };
    },
);

has 'api_version' => (
    is      => 'ro',
    isa     => Num,
    default => sub { '3.0' },
);

has 'datacenter' => (
    is      => 'lazy',
    isa     => Str,
    default => sub {
        my $self = shift;
        if ($self->api_key) {
            my ($dc) = ( $self->api_key =~ /\-(\w+)$/ );
            return $dc;
        }
        else {
            return 'us1';
        }
    },
);

=head1 INTERNALS

=over

=item commands

Required by Web::API

=back

=cut

sub commands {
    my ($self) = @_;
    return $self->endpoints;
}

=head2 BUILD

basic configuration for the client API happens usually in the BUILD method when using Web::API

=cut

sub BUILD {
    my ($self) = @_;

    $self->user_agent( __PACKAGE__ . ' ' . $Mail::Chimp3::VERSION );
    $self->base_url( 'https://' . $self->datacenter . '.api.mailchimp.com/' . $self->api_version . '/' );
    $self->auth_type('basic');
    $self->user('anystring');
    $self->content_type('application/json');

    return $self;
}

=head1 BUGS

Please report any bugs or feature requests on GitHub's issue tracker L<https://github.com/jdigory/p5-Mail-Chimp3/issues>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Mail::Chimp3

You can also look for information at:

=over 4

=item * GitHub repository

L<https://github.com/jdigory/p5-Mail-Chimp3>

=back

=cut

1;

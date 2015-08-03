#!/usr/bin/perl -w

# Snapshot Reminder v0.1
# Author: Joerg Kastning (joerg.kastning@uni-bielefeld.de)
#
# This program gathers information about existing snapshots for the Virtual Machines in
# VMware vCenter. It reports the information about the snapshots via e-mail to an address,
# which is given in the custom field "maintainer_email".
#
# Version History:
# v1.0
#
# Connect to https://<fqdn>/sdk/webService

use strict;
use warnings;
use VMware::VIRuntime;

# read/validate options and connect to the server
# Opts::add_options(%opts);
Opts::parse();
Opts::validate();
Util::connect();

my $CustomFieldsManager = Vim::get_view(mo_ref => Vim::get_service_content()->customFieldsManager);
my $maintainer_email_key = -1;

if (defined $CustomFieldsManager->{field}) # Are there any custom fields?
	{
		my $fields = $CustomFieldsManager->{field};

    		foreach(@$fields) # Check existing custom fields if 'maintainer_email' exists
			{
				if ($_->name eq "maintainer_email")
				{ $maintainer_email_key = $_->key; }
			}
	}

if ($maintainer_email_key == -1 )    #---- If no custom field called 'maintainer_email' is found, let's create it
{
   my $result = $CustomFieldsManager-> AddCustomFieldDef(name=>"maintainer_email");
   $maintainer_email_key = $result->key;
}

my $vms = Vim::find_entity_views(view_type => 'VirtualMachine', properties => ['summary.customValue','name',], );

for my $vm (@$vms) {
	my $cv_ref = $vm->{'summary.customValue'};
	next unless defined($vm->{'summary.customValue'});
	print $vm->name . "\n";
	for (@$cv_ref) {
		next unless defined $_->value;
		print "key: ",$_->key,"\tvalue: ",$_->value,"\n";
	}
}

# disconnect from the server
Util::disconnect();

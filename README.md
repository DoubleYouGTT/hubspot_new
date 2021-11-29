
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hubspot

> Access Hubspot CRM data in R.

<!-- badges: start -->
[![Project Status: WIP - Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
<!-- badges: end -->

The goal of `hubspot` is to enable access to [Hubspot CRM](//hubspot.com) data. It uses the [HubSpot API v3](//developers.hubspot.com/docs/api/crm/understanding-the-crm) and the [Hubspot legacy API v1](//legacydocs.hubspot.com/docs/overview).

## Updated version

The [orginal hubspot package by lockedata](https://github.com/lockedata/hubspot) hasn't been updated for long and only used `GET` connections. Since then, HubSpot has made a new API and new functionality. This package provides extended functionality while following the same naming conventions and keeping the original functions.

## Function overview 

The original (legacy API) functions are named following the
`hs_<endpointname>_raw()`/`hs_<endpointname>_tidy()` structure. The `_raw()` functions return lists based on the JSON structure of the HubSpot API, while the `_tidy()` functions return a tibble offering at least one view.

> For example, a nested list of deals data can be obtained with `hs_deals_raw()` and be transformed to a tibble of associations, properties history, properties or stages history with `hs_deals_tidy()`.

The new (API v3) functions are named following the `hs_<action>_<endpoint>_<type>()` structure. They all return raw lists based on the JSON structure of the HubSpot API. The following functions exist:
- `hs_get_<endpoint>_list()`: obtain a full list of objects
- `hs_create_<endpoint>()`: create one or more objects
- `hs_get_<endpoint>()`: obtain one or more objects based on the identifiers
- `hs_update_<endpoint>()`: update one or more objects
- `hs_delete_<endpoint>()`: delete one or more objects
- `hs_get_<endpoint>_association()`: get all associations of a specific type for one object
- `hs_create_<endpoint>_association()`: create one association between the object and another
- `hs_delete_<endpoint>_association()`: delete one association between the object and another

> For example, a nested list of products data can be obtained with `hs_get_product_list()`, but also with `hs_get_product()` if identifiers are known.

A full list of all functions and their parameters can be found in the "[hubspot.pdf](hubspot.pdf)" file. The package currently support the following `GET` endpoints of the legacy API v1:
- API usage
- Companies
- Company properties
- Contacts
- Contact lists
- Contact properties
- Deals
- Deal pipelines
- Deal properties
- Engagements
- Forms
- Line items
- Object properties (for tickets, products, and line items)
- Owners
- Products
- Tickets

The package also supports the following `GET`, `POST`, `PUT`, `PATCH` and `DELETE` endpoints of the API v3:
- Products


## Example

``` r
library("hubspot")

deal_props <- hs_deal_properties_tidy()
head(deal_props)
#> [1] "amount_in_home_currency"    "days_to_close"             
#> [3] "hs_analytics_source"        "hs_analytics_source_data_1"
#> [5] "hs_analytics_source_data_2" "hs_campaign"

deals <- hs_deals_raw(properties = deal_props, max_iter = 1)
```

<details closed>

<summary> <span title="Click to Expand"> Click to see the
<code>deals</code> nested list </span> </summary>

``` r

$`931633510`
$`931633510`$portalId
[1] 62515

$`931633510`$dealId
[1] 931633510

$`931633510`$isDeleted
[1] FALSE

$`931633510`$associations
$`931633510`$associations$associatedVids
list()

$`931633510`$associations$associatedCompanyIds
list()

$`931633510`$associations$associatedDealIds
list()

$`931633510`$associations$associatedTicketIds
list()


$`931633510`$properties
$`931633510`$properties$hs_closed_amount_in_home_currency
$`931633510`$properties$hs_closed_amount_in_home_currency$value
[1] "0"

$`931633510`$properties$hs_closed_amount_in_home_currency$timestamp
[1] 1.571769e+12

$`931633510`$properties$hs_closed_amount_in_home_currency$source
[1] "CALCULATED"

$`931633510`$properties$hs_closed_amount_in_home_currency$sourceId
NULL

$`931633510`$properties$hs_closed_amount_in_home_currency$versions
$`931633510`$properties$hs_closed_amount_in_home_currency$versions[[1]]
$`931633510`$properties$hs_closed_amount_in_home_currency$versions[[1]]$name
[1] "hs_closed_amount_in_home_currency"

$`931633510`$properties$hs_closed_amount_in_home_currency$versions[[1]]$value
[1] "0"

$`931633510`$properties$hs_closed_amount_in_home_currency$versions[[1]]$timestamp
[1] 1.571769e+12

$`931633510`$properties$hs_closed_amount_in_home_currency$versions[[1]]$source
[1] "CALCULATED"

$`931633510`$properties$hs_closed_amount_in_home_currency$versions[[1]]$sourceVid
list()

$`931633510`$properties$hs_closed_amount_in_home_currency$versions[[1]]$sourceMetadata
[1] ""




$`931633510`$properties$dealname
$`931633510`$properties$dealname$value
[1] "Example deal"

$`931633510`$properties$dealname$timestamp
[1] 1.565734e+12

$`931633510`$properties$dealname$source
[1] "CRM_UI"

$`931633510`$properties$dealname$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$dealname$versions
$`931633510`$properties$dealname$versions[[1]]
$`931633510`$properties$dealname$versions[[1]]$name
[1] "dealname"

$`931633510`$properties$dealname$versions[[1]]$value
[1] "Example deal"

$`931633510`$properties$dealname$versions[[1]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$dealname$versions[[1]]$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$dealname$versions[[1]]$source
[1] "CRM_UI"

$`931633510`$properties$dealname$versions[[1]]$sourceVid
list()




$`931633510`$properties$hs_all_accessible_team_ids
$`931633510`$properties$hs_all_accessible_team_ids$value
[1] ""

$`931633510`$properties$hs_all_accessible_team_ids$timestamp
[1] 1.565735e+12

$`931633510`$properties$hs_all_accessible_team_ids$source
[1] "CRM_UI"

$`931633510`$properties$hs_all_accessible_team_ids$sourceId
[1] "PermissionsUpdater"

$`931633510`$properties$hs_all_accessible_team_ids$versions
$`931633510`$properties$hs_all_accessible_team_ids$versions[[1]]
$`931633510`$properties$hs_all_accessible_team_ids$versions[[1]]$name
[1] "hs_all_accessible_team_ids"

$`931633510`$properties$hs_all_accessible_team_ids$versions[[1]]$value
[1] ""

$`931633510`$properties$hs_all_accessible_team_ids$versions[[1]]$timestamp
[1] 1.565735e+12

$`931633510`$properties$hs_all_accessible_team_ids$versions[[1]]$sourceId
[1] "PermissionsUpdater"

$`931633510`$properties$hs_all_accessible_team_ids$versions[[1]]$source
[1] "CRM_UI"

$`931633510`$properties$hs_all_accessible_team_ids$versions[[1]]$sourceVid
list()


$`931633510`$properties$hs_all_accessible_team_ids$versions[[2]]
$`931633510`$properties$hs_all_accessible_team_ids$versions[[2]]$name
[1] "hs_all_accessible_team_ids"

$`931633510`$properties$hs_all_accessible_team_ids$versions[[2]]$value
[1] "112117"

$`931633510`$properties$hs_all_accessible_team_ids$versions[[2]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$hs_all_accessible_team_ids$versions[[2]]$sourceId
[1] "PermissionsUpdater"

$`931633510`$properties$hs_all_accessible_team_ids$versions[[2]]$source
[1] "CRM_UI"

$`931633510`$properties$hs_all_accessible_team_ids$versions[[2]]$sourceVid
list()




$`931633510`$properties$amount
$`931633510`$properties$amount$value
[1] "100"

$`931633510`$properties$amount$timestamp
[1] 1.565734e+12

$`931633510`$properties$amount$source
[1] "CRM_UI"

$`931633510`$properties$amount$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$amount$versions
$`931633510`$properties$amount$versions[[1]]
$`931633510`$properties$amount$versions[[1]]$name
[1] "amount"

$`931633510`$properties$amount$versions[[1]]$value
[1] "100"

$`931633510`$properties$amount$versions[[1]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$amount$versions[[1]]$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$amount$versions[[1]]$source
[1] "CRM_UI"

$`931633510`$properties$amount$versions[[1]]$sourceVid
list()




$`931633510`$properties$closedate
$`931633510`$properties$closedate$value
[1] "1564783118291"

$`931633510`$properties$closedate$timestamp
[1] 1.565734e+12

$`931633510`$properties$closedate$source
[1] "CRM_UI"

$`931633510`$properties$closedate$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$closedate$versions
$`931633510`$properties$closedate$versions[[1]]
$`931633510`$properties$closedate$versions[[1]]$name
[1] "closedate"

$`931633510`$properties$closedate$versions[[1]]$value
[1] "1564783118291"

$`931633510`$properties$closedate$versions[[1]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$closedate$versions[[1]]$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$closedate$versions[[1]]$source
[1] "CRM_UI"

$`931633510`$properties$closedate$versions[[1]]$sourceVid
list()




$`931633510`$properties$num_associated_contacts
$`931633510`$properties$num_associated_contacts$value
[1] "0"

$`931633510`$properties$num_associated_contacts$timestamp
[1] 1.566463e+12

$`931633510`$properties$num_associated_contacts$source
[1] "CALCULATED"

$`931633510`$properties$num_associated_contacts$sourceId
NULL

$`931633510`$properties$num_associated_contacts$versions
$`931633510`$properties$num_associated_contacts$versions[[1]]
$`931633510`$properties$num_associated_contacts$versions[[1]]$name
[1] "num_associated_contacts"

$`931633510`$properties$num_associated_contacts$versions[[1]]$value
[1] "0"

$`931633510`$properties$num_associated_contacts$versions[[1]]$timestamp
[1] 1.566463e+12

$`931633510`$properties$num_associated_contacts$versions[[1]]$source
[1] "CALCULATED"

$`931633510`$properties$num_associated_contacts$versions[[1]]$sourceVid
list()




$`931633510`$properties$hs_all_team_ids
$`931633510`$properties$hs_all_team_ids$value
[1] ""

$`931633510`$properties$hs_all_team_ids$timestamp
[1] 1.565735e+12

$`931633510`$properties$hs_all_team_ids$source
[1] "CRM_UI"

$`931633510`$properties$hs_all_team_ids$sourceId
[1] "PermissionsUpdater"

$`931633510`$properties$hs_all_team_ids$versions
$`931633510`$properties$hs_all_team_ids$versions[[1]]
$`931633510`$properties$hs_all_team_ids$versions[[1]]$name
[1] "hs_all_team_ids"

$`931633510`$properties$hs_all_team_ids$versions[[1]]$value
[1] ""

$`931633510`$properties$hs_all_team_ids$versions[[1]]$timestamp
[1] 1.565735e+12

$`931633510`$properties$hs_all_team_ids$versions[[1]]$sourceId
[1] "PermissionsUpdater"

$`931633510`$properties$hs_all_team_ids$versions[[1]]$source
[1] "CRM_UI"

$`931633510`$properties$hs_all_team_ids$versions[[1]]$sourceVid
list()


$`931633510`$properties$hs_all_team_ids$versions[[2]]
$`931633510`$properties$hs_all_team_ids$versions[[2]]$name
[1] "hs_all_team_ids"

$`931633510`$properties$hs_all_team_ids$versions[[2]]$value
[1] "112117"

$`931633510`$properties$hs_all_team_ids$versions[[2]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$hs_all_team_ids$versions[[2]]$sourceId
[1] "PermissionsUpdater"

$`931633510`$properties$hs_all_team_ids$versions[[2]]$source
[1] "CRM_UI"

$`931633510`$properties$hs_all_team_ids$versions[[2]]$sourceVid
list()




$`931633510`$properties$createdate
$`931633510`$properties$createdate$value
[1] "1565733501511"

$`931633510`$properties$createdate$timestamp
[1] 1.565734e+12

$`931633510`$properties$createdate$source
[1] "CRM_UI"

$`931633510`$properties$createdate$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$createdate$versions
$`931633510`$properties$createdate$versions[[1]]
$`931633510`$properties$createdate$versions[[1]]$name
[1] "createdate"

$`931633510`$properties$createdate$versions[[1]]$value
[1] "1565733501511"

$`931633510`$properties$createdate$versions[[1]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$createdate$versions[[1]]$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$createdate$versions[[1]]$source
[1] "CRM_UI"

$`931633510`$properties$createdate$versions[[1]]$sourceVid
list()




$`931633510`$properties$hs_is_closed
$`931633510`$properties$hs_is_closed$value
[1] "false"

$`931633510`$properties$hs_is_closed$timestamp
[1] 1.571769e+12

$`931633510`$properties$hs_is_closed$source
[1] "CALCULATED"

$`931633510`$properties$hs_is_closed$sourceId
NULL

$`931633510`$properties$hs_is_closed$versions
$`931633510`$properties$hs_is_closed$versions[[1]]
$`931633510`$properties$hs_is_closed$versions[[1]]$name
[1] "hs_is_closed"

$`931633510`$properties$hs_is_closed$versions[[1]]$value
[1] "false"

$`931633510`$properties$hs_is_closed$versions[[1]]$timestamp
[1] 1.571769e+12

$`931633510`$properties$hs_is_closed$versions[[1]]$source
[1] "CALCULATED"

$`931633510`$properties$hs_is_closed$versions[[1]]$sourceVid
list()

$`931633510`$properties$hs_is_closed$versions[[1]]$sourceMetadata
[1] ""




$`931633510`$properties$amount_in_home_currency
$`931633510`$properties$amount_in_home_currency$value
[1] "100"

$`931633510`$properties$amount_in_home_currency$timestamp
[1] 1.565734e+12

$`931633510`$properties$amount_in_home_currency$source
[1] "CALCULATED"

$`931633510`$properties$amount_in_home_currency$sourceId
NULL

$`931633510`$properties$amount_in_home_currency$versions
$`931633510`$properties$amount_in_home_currency$versions[[1]]
$`931633510`$properties$amount_in_home_currency$versions[[1]]$name
[1] "amount_in_home_currency"

$`931633510`$properties$amount_in_home_currency$versions[[1]]$value
[1] "100"

$`931633510`$properties$amount_in_home_currency$versions[[1]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$amount_in_home_currency$versions[[1]]$source
[1] "CALCULATED"

$`931633510`$properties$amount_in_home_currency$versions[[1]]$sourceVid
list()

$`931633510`$properties$amount_in_home_currency$versions[[1]]$sourceMetadata
[1] ""




$`931633510`$properties$hs_deal_stage_probability
$`931633510`$properties$hs_deal_stage_probability$value
[1] "0.59999999999999997779553950749686919152736663818359375"

$`931633510`$properties$hs_deal_stage_probability$timestamp
[1] 1.571769e+12

$`931633510`$properties$hs_deal_stage_probability$source
[1] "CALCULATED"

$`931633510`$properties$hs_deal_stage_probability$sourceId
NULL

$`931633510`$properties$hs_deal_stage_probability$versions
$`931633510`$properties$hs_deal_stage_probability$versions[[1]]
$`931633510`$properties$hs_deal_stage_probability$versions[[1]]$name
[1] "hs_deal_stage_probability"

$`931633510`$properties$hs_deal_stage_probability$versions[[1]]$value
[1] "0.59999999999999997779553950749686919152736663818359375"

$`931633510`$properties$hs_deal_stage_probability$versions[[1]]$timestamp
[1] 1.571769e+12

$`931633510`$properties$hs_deal_stage_probability$versions[[1]]$source
[1] "CALCULATED"

$`931633510`$properties$hs_deal_stage_probability$versions[[1]]$sourceVid
list()

$`931633510`$properties$hs_deal_stage_probability$versions[[1]]$sourceMetadata
[1] ""




$`931633510`$properties$days_to_close
$`931633510`$properties$days_to_close$value
[1] "0"

$`931633510`$properties$days_to_close$timestamp
[1] 1.565734e+12

$`931633510`$properties$days_to_close$source
[1] "CALCULATED"

$`931633510`$properties$days_to_close$sourceId
NULL

$`931633510`$properties$days_to_close$versions
$`931633510`$properties$days_to_close$versions[[1]]
$`931633510`$properties$days_to_close$versions[[1]]$name
[1] "days_to_close"

$`931633510`$properties$days_to_close$versions[[1]]$value
[1] "0"

$`931633510`$properties$days_to_close$versions[[1]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$days_to_close$versions[[1]]$source
[1] "CALCULATED"

$`931633510`$properties$days_to_close$versions[[1]]$sourceVid
list()

$`931633510`$properties$days_to_close$versions[[1]]$sourceMetadata
[1] ""




$`931633510`$properties$pipeline
$`931633510`$properties$pipeline$value
[1] "default"

$`931633510`$properties$pipeline$timestamp
[1] 1.565734e+12

$`931633510`$properties$pipeline$source
[1] "CRM_UI"

$`931633510`$properties$pipeline$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$pipeline$versions
$`931633510`$properties$pipeline$versions[[1]]
$`931633510`$properties$pipeline$versions[[1]]$name
[1] "pipeline"

$`931633510`$properties$pipeline$versions[[1]]$value
[1] "default"

$`931633510`$properties$pipeline$versions[[1]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$pipeline$versions[[1]]$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$pipeline$versions[[1]]$source
[1] "CRM_UI"

$`931633510`$properties$pipeline$versions[[1]]$sourceVid
list()




$`931633510`$properties$hubspot_team_id
$`931633510`$properties$hubspot_team_id$value
[1] ""

$`931633510`$properties$hubspot_team_id$timestamp
[1] 1.565735e+12

$`931633510`$properties$hubspot_team_id$source
[1] "CRM_UI"

$`931633510`$properties$hubspot_team_id$sourceId
[1] "PermissionsUpdater"

$`931633510`$properties$hubspot_team_id$versions
$`931633510`$properties$hubspot_team_id$versions[[1]]
$`931633510`$properties$hubspot_team_id$versions[[1]]$name
[1] "hubspot_team_id"

$`931633510`$properties$hubspot_team_id$versions[[1]]$value
[1] ""

$`931633510`$properties$hubspot_team_id$versions[[1]]$timestamp
[1] 1.565735e+12

$`931633510`$properties$hubspot_team_id$versions[[1]]$sourceId
[1] "PermissionsUpdater"

$`931633510`$properties$hubspot_team_id$versions[[1]]$source
[1] "CRM_UI"

$`931633510`$properties$hubspot_team_id$versions[[1]]$sourceVid
list()


$`931633510`$properties$hubspot_team_id$versions[[2]]
$`931633510`$properties$hubspot_team_id$versions[[2]]$name
[1] "hubspot_team_id"

$`931633510`$properties$hubspot_team_id$versions[[2]]$value
[1] "112117"

$`931633510`$properties$hubspot_team_id$versions[[2]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$hubspot_team_id$versions[[2]]$sourceId
[1] "PermissionsUpdater"

$`931633510`$properties$hubspot_team_id$versions[[2]]$source
[1] "CRM_UI"

$`931633510`$properties$hubspot_team_id$versions[[2]]$sourceVid
list()




$`931633510`$properties$hubspot_owner_id
$`931633510`$properties$hubspot_owner_id$value
[1] "71"

$`931633510`$properties$hubspot_owner_id$timestamp
[1] 1.565734e+12

$`931633510`$properties$hubspot_owner_id$source
[1] "CRM_UI"

$`931633510`$properties$hubspot_owner_id$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$hubspot_owner_id$versions
$`931633510`$properties$hubspot_owner_id$versions[[1]]
$`931633510`$properties$hubspot_owner_id$versions[[1]]$name
[1] "hubspot_owner_id"

$`931633510`$properties$hubspot_owner_id$versions[[1]]$value
[1] "71"

$`931633510`$properties$hubspot_owner_id$versions[[1]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$hubspot_owner_id$versions[[1]]$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$hubspot_owner_id$versions[[1]]$source
[1] "CRM_UI"

$`931633510`$properties$hubspot_owner_id$versions[[1]]$sourceVid
list()




$`931633510`$properties$hs_closed_amount
$`931633510`$properties$hs_closed_amount$value
[1] "0"

$`931633510`$properties$hs_closed_amount$timestamp
[1] 1.571769e+12

$`931633510`$properties$hs_closed_amount$source
[1] "CALCULATED"

$`931633510`$properties$hs_closed_amount$sourceId
NULL

$`931633510`$properties$hs_closed_amount$versions
$`931633510`$properties$hs_closed_amount$versions[[1]]
$`931633510`$properties$hs_closed_amount$versions[[1]]$name
[1] "hs_closed_amount"

$`931633510`$properties$hs_closed_amount$versions[[1]]$value
[1] "0"

$`931633510`$properties$hs_closed_amount$versions[[1]]$timestamp
[1] 1.571769e+12

$`931633510`$properties$hs_closed_amount$versions[[1]]$source
[1] "CALCULATED"

$`931633510`$properties$hs_closed_amount$versions[[1]]$sourceVid
list()

$`931633510`$properties$hs_closed_amount$versions[[1]]$sourceMetadata
[1] ""




$`931633510`$properties$hs_lastmodifieddate
$`931633510`$properties$hs_lastmodifieddate$value
[1] "1565735453314"

$`931633510`$properties$hs_lastmodifieddate$timestamp
[1] 1.565735e+12

$`931633510`$properties$hs_lastmodifieddate$source
[1] "CALCULATED"

$`931633510`$properties$hs_lastmodifieddate$sourceId
NULL

$`931633510`$properties$hs_lastmodifieddate$versions
$`931633510`$properties$hs_lastmodifieddate$versions[[1]]
$`931633510`$properties$hs_lastmodifieddate$versions[[1]]$name
[1] "hs_lastmodifieddate"

$`931633510`$properties$hs_lastmodifieddate$versions[[1]]$value
[1] "1565735453314"

$`931633510`$properties$hs_lastmodifieddate$versions[[1]]$timestamp
[1] 1.565735e+12

$`931633510`$properties$hs_lastmodifieddate$versions[[1]]$source
[1] "CALCULATED"

$`931633510`$properties$hs_lastmodifieddate$versions[[1]]$sourceVid
list()


$`931633510`$properties$hs_lastmodifieddate$versions[[2]]
$`931633510`$properties$hs_lastmodifieddate$versions[[2]]$name
[1] "hs_lastmodifieddate"

$`931633510`$properties$hs_lastmodifieddate$versions[[2]]$value
[1] "1565733538147"

$`931633510`$properties$hs_lastmodifieddate$versions[[2]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$hs_lastmodifieddate$versions[[2]]$source
[1] "CALCULATED"

$`931633510`$properties$hs_lastmodifieddate$versions[[2]]$sourceVid
list()


$`931633510`$properties$hs_lastmodifieddate$versions[[3]]
$`931633510`$properties$hs_lastmodifieddate$versions[[3]]$name
[1] "hs_lastmodifieddate"

$`931633510`$properties$hs_lastmodifieddate$versions[[3]]$value
[1] "1565733537449"

$`931633510`$properties$hs_lastmodifieddate$versions[[3]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$hs_lastmodifieddate$versions[[3]]$source
[1] "CALCULATED"

$`931633510`$properties$hs_lastmodifieddate$versions[[3]]$sourceVid
list()




$`931633510`$properties$hubspot_owner_assigneddate
$`931633510`$properties$hubspot_owner_assigneddate$value
[1] "1565733537449"

$`931633510`$properties$hubspot_owner_assigneddate$timestamp
[1] 1.565734e+12

$`931633510`$properties$hubspot_owner_assigneddate$source
[1] "CRM_UI"

$`931633510`$properties$hubspot_owner_assigneddate$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$hubspot_owner_assigneddate$versions
$`931633510`$properties$hubspot_owner_assigneddate$versions[[1]]
$`931633510`$properties$hubspot_owner_assigneddate$versions[[1]]$name
[1] "hubspot_owner_assigneddate"

$`931633510`$properties$hubspot_owner_assigneddate$versions[[1]]$value
[1] "1565733537449"

$`931633510`$properties$hubspot_owner_assigneddate$versions[[1]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$hubspot_owner_assigneddate$versions[[1]]$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$hubspot_owner_assigneddate$versions[[1]]$source
[1] "CRM_UI"

$`931633510`$properties$hubspot_owner_assigneddate$versions[[1]]$sourceVid
list()




$`931633510`$properties$dealstage
$`931633510`$properties$dealstage$value
[1] "presentationscheduled"

$`931633510`$properties$dealstage$timestamp
[1] 1.565734e+12

$`931633510`$properties$dealstage$source
[1] "CRM_UI"

$`931633510`$properties$dealstage$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$dealstage$versions
$`931633510`$properties$dealstage$versions[[1]]
$`931633510`$properties$dealstage$versions[[1]]$name
[1] "dealstage"

$`931633510`$properties$dealstage$versions[[1]]$value
[1] "presentationscheduled"

$`931633510`$properties$dealstage$versions[[1]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$dealstage$versions[[1]]$sourceId
[1] "dadams@hubspot.com"

$`931633510`$properties$dealstage$versions[[1]]$source
[1] "CRM_UI"

$`931633510`$properties$dealstage$versions[[1]]$sourceVid
list()




$`931633510`$properties$hs_createdate
$`931633510`$properties$hs_createdate$value
[1] "1565733537449"

$`931633510`$properties$hs_createdate$timestamp
[1] 1.565734e+12

$`931633510`$properties$hs_createdate$source
[1] "CONTACTS"

$`931633510`$properties$hs_createdate$sourceId
[1] "CRM_UI"

$`931633510`$properties$hs_createdate$versions
$`931633510`$properties$hs_createdate$versions[[1]]
$`931633510`$properties$hs_createdate$versions[[1]]$name
[1] "hs_createdate"

$`931633510`$properties$hs_createdate$versions[[1]]$value
[1] "1565733537449"

$`931633510`$properties$hs_createdate$versions[[1]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$hs_createdate$versions[[1]]$sourceId
[1] "CRM_UI"

$`931633510`$properties$hs_createdate$versions[[1]]$source
[1] "CONTACTS"

$`931633510`$properties$hs_createdate$versions[[1]]$sourceVid
list()




$`931633510`$properties$hs_object_id
$`931633510`$properties$hs_object_id$value
[1] "931633510"

$`931633510`$properties$hs_object_id$timestamp
[1] 1.565734e+12

$`931633510`$properties$hs_object_id$source
[1] "CALCULATED"

$`931633510`$properties$hs_object_id$sourceId
NULL

$`931633510`$properties$hs_object_id$versions
$`931633510`$properties$hs_object_id$versions[[1]]
$`931633510`$properties$hs_object_id$versions[[1]]$name
[1] "hs_object_id"

$`931633510`$properties$hs_object_id$versions[[1]]$value
[1] "931633510"

$`931633510`$properties$hs_object_id$versions[[1]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$hs_object_id$versions[[1]]$source
[1] "CALCULATED"

$`931633510`$properties$hs_object_id$versions[[1]]$sourceVid
list()




$`931633510`$properties$hs_projected_amount
$`931633510`$properties$hs_projected_amount$value
[1] "59.99999999999999777955395074968691915273666381835937500"

$`931633510`$properties$hs_projected_amount$timestamp
[1] 1.571769e+12

$`931633510`$properties$hs_projected_amount$source
[1] "CALCULATED"

$`931633510`$properties$hs_projected_amount$sourceId
NULL

$`931633510`$properties$hs_projected_amount$versions
$`931633510`$properties$hs_projected_amount$versions[[1]]
$`931633510`$properties$hs_projected_amount$versions[[1]]$name
[1] "hs_projected_amount"

$`931633510`$properties$hs_projected_amount$versions[[1]]$value
[1] "59.99999999999999777955395074968691915273666381835937500"

$`931633510`$properties$hs_projected_amount$versions[[1]]$timestamp
[1] 1.571769e+12

$`931633510`$properties$hs_projected_amount$versions[[1]]$source
[1] "CALCULATED"

$`931633510`$properties$hs_projected_amount$versions[[1]]$sourceVid
list()

$`931633510`$properties$hs_projected_amount$versions[[1]]$sourceMetadata
[1] ""




$`931633510`$properties$hs_all_owner_ids
$`931633510`$properties$hs_all_owner_ids$value
[1] "71"

$`931633510`$properties$hs_all_owner_ids$timestamp
[1] 1.565734e+12

$`931633510`$properties$hs_all_owner_ids$source
[1] "CRM_UI"

$`931633510`$properties$hs_all_owner_ids$sourceId
[1] "PermissionsUpdater"

$`931633510`$properties$hs_all_owner_ids$versions
$`931633510`$properties$hs_all_owner_ids$versions[[1]]
$`931633510`$properties$hs_all_owner_ids$versions[[1]]$name
[1] "hs_all_owner_ids"

$`931633510`$properties$hs_all_owner_ids$versions[[1]]$value
[1] "71"

$`931633510`$properties$hs_all_owner_ids$versions[[1]]$timestamp
[1] 1.565734e+12

$`931633510`$properties$hs_all_owner_ids$versions[[1]]$sourceId
[1] "PermissionsUpdater"

$`931633510`$properties$hs_all_owner_ids$versions[[1]]$source
[1] "CRM_UI"

$`931633510`$properties$hs_all_owner_ids$versions[[1]]$sourceVid
list()




$`931633510`$properties$hs_projected_amount_in_home_currency
$`931633510`$properties$hs_projected_amount_in_home_currency$value
[1] "59.99999999999999777955395074968691915273666381835937500"

$`931633510`$properties$hs_projected_amount_in_home_currency$timestamp
[1] 1.571769e+12

$`931633510`$properties$hs_projected_amount_in_home_currency$source
[1] "CALCULATED"

$`931633510`$properties$hs_projected_amount_in_home_currency$sourceId
NULL

$`931633510`$properties$hs_projected_amount_in_home_currency$versions
$`931633510`$properties$hs_projected_amount_in_home_currency$versions[[1]]
$`931633510`$properties$hs_projected_amount_in_home_currency$versions[[1]]$name
[1] "hs_projected_amount_in_home_currency"

$`931633510`$properties$hs_projected_amount_in_home_currency$versions[[1]]$value
[1] "59.99999999999999777955395074968691915273666381835937500"

$`931633510`$properties$hs_projected_amount_in_home_currency$versions[[1]]$timestamp
[1] 1.571769e+12

$`931633510`$properties$hs_projected_amount_in_home_currency$versions[[1]]$source
[1] "CALCULATED"

$`931633510`$properties$hs_projected_amount_in_home_currency$versions[[1]]$sourceVid
list()

$`931633510`$properties$hs_projected_amount_in_home_currency$versions[[1]]$sourceMetadata
[1] ""





$`931633510`$imports
list()

$`931633510`$stateChanges
list()
```

</details>

<br>

``` r
deal_stages <- hs_deals_tidy(deals, view = "properties")
deal_stages
#> # A tibble: 1 x 25
#>   dealId hs_closed_amoun… dealname hs_all_accessib… amount closedate          
#>    <dbl>            <dbl> <chr>    <chr>             <dbl> <dttm>             
#> 1 9.32e8                0 Example… ""                  100 2019-08-02 23:58:38
#> # … with 19 more variables: num_associated_contacts <dbl>,
#> #   hs_all_team_ids <chr>, createdate <dttm>, hs_is_closed <chr>,
#> #   amount_in_home_currency <dbl>, hs_deal_stage_probability <dbl>,
#> #   days_to_close <dbl>, pipeline <chr>, hubspot_team_id <chr>,
#> #   hubspot_owner_id <dbl>, hs_closed_amount <dbl>, hs_lastmodifieddate <dttm>,
#> #   hubspot_owner_assigneddate <dttm>, dealstage <chr>, hs_createdate <dttm>,
#> #   hs_object_id <dbl>, hs_projected_amount <dbl>, hs_all_owner_ids <dbl>,
#> #   hs_projected_amount_in_home_currency <dbl>
```

## Installation

``` r
remotes::install_github("DoubleYouGTT/hubspot")
```

## Authorization for Hubspot APIs

The Hubspot API accepts authorization via

  - an API key,

  - OAuth 2.0.

OAuth 2.0 is the [recommended method](https://legacydocs.hubspot.com/docs/methods/auth/oauth-overview). However, this package supports both.

Note that if you do nothing the package will use the “demo” API token but this won’t give you access to your own Hubspot data. So you’ll need to spend a little time on setup:

  - For rapid prototyping key, use a Hubspot API key, see `hubspot_key_set()`.

  - For more secure use, without a daily limit on API calls, see `hubspot_token_create()` to create a Hubspot authorization token (OAuth 2.0).

If you have both saved an API key via `hubspot_key_set()` and a token via `hubspot_token_create()`, priority will be given to using the OAuth 2.0 token. If you don’t want that, explicitely pass `NULL` as value for the `token_path` argument of all functions.

Find more details on each method [in lockedata's vignette about authorization](https://itsalocke.com/hubspot/articles/auth).

## Contributions welcome\!

If you like to report a bug or suggest a feature, feel free to submit an issue at the [issue tab](https://github.com/DoubleYouGTT/hubspot/issues).

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

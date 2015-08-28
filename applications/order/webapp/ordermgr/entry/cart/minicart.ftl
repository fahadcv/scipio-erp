<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<#assign shoppingCart = sessionAttributes.shoppingCart!>
<#if shoppingCart?has_content>
    <#assign shoppingCartSize = shoppingCart.size()>
<#else>
    <#assign shoppingCartSize = 0>
</#if>

<@section id="minicart" title="${uiLabelMap.OrderCartSummary}">
        <#if (shoppingCartSize > 0)>
          <#macro cartLinks>
            <ul class="${styles.button_group!}">
              <li><a href="<@ofbizUrl>view/showcart</@ofbizUrl>" class="${styles.button_default!}">${uiLabelMap.OrderViewCart}</a></li>
              <li><a href="<@ofbizUrl>checkoutoptions</@ofbizUrl>" class="${styles.button_default!}">${uiLabelMap.OrderCheckout}</a></li>
              <li><a href="<@ofbizUrl>quickcheckout</@ofbizUrl>" class="${styles.button_default!}">${uiLabelMap.OrderCheckoutQuick}</a></li>
              <li><a href="<@ofbizUrl>onePageCheckout</@ofbizUrl>" class="${styles.button_default!}">${uiLabelMap.EcommerceOnePageCheckout}</a></li>
              <li><a href="<@ofbizUrl>googleCheckout</@ofbizUrl>" class="${styles.button_default!}">${uiLabelMap.EcommerceCartToGoogleCheckout}</a></li>
            </ul>
          </#macro>
        
          <#if hidetoplinks?default("N") != "Y">
            <@cartLinks />
          </#if>
          
          <@table type="data-complex" class="">
            <@thead>
              <@tr>
                <@th>${uiLabelMap.OrderQty}</@th>
                <@th>${uiLabelMap.OrderItem}</@th>
                <@th>${uiLabelMap.CommonSubtotal}</@th>
              </@tr>
            </@thead>
            <@tfoot>
              <@tr>
                <@td colspan="3">
                  ${uiLabelMap.OrderTotal}: <@ofbizCurrency amount=shoppingCart.getDisplayGrandTotal() isoCode=shoppingCart.getCurrency()/>
                </@td>
              </@tr>
            </@tfoot>
            <@tbody>
            <#list shoppingCart.items() as cartLine>
              <@tr>
                <@td>${cartLine.getQuantity()?string.number}</@td>
                <@td>
                  <#if cartLine.getProductId()??>
                      <#if cartLine.getParentProductId()??>
                          <a href="<@ofbizCatalogAltUrl productId=cartLine.getParentProductId()/>" class="linktext ${styles.button_default!}">${cartLine.getName()}</a>
                      <#else>
                          <a href="<@ofbizCatalogAltUrl productId=cartLine.getProductId()/>" class="linktext ${styles.button_default!}">${cartLine.getName()}</a>
                      </#if>
                  <#else>
                    <strong>${cartLine.getItemTypeDescription()!}</strong>
                  </#if>
                </@td>
                <@td><@ofbizCurrency amount=cartLine.getDisplayItemSubTotal() isoCode=shoppingCart.getCurrency()/></@td>
              </@tr>
              <#if cartLine.getReservStart()??>
                <@tr><@td>&nbsp;</@td><@td colspan="2">(${cartLine.getReservStart()?string("yyyy-MM-dd")}, ${cartLine.getReservLength()} <#if cartLine.getReservLength() == 1>${uiLabelMap.CommonDay}<#else>${uiLabelMap.CommonDays}</#if>)</@td></@tr>
              </#if>
            </#list>
            </@tbody>
          </@table>
          
          <#if hidebottomlinks?default("N") != "Y">
            <@cartLinks />
          </#if>
        <#else>
          <@resultMsg>${uiLabelMap.OrderShoppingCartEmpty}</@resultMsg>
        </#if>
</@section>

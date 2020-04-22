<#-- WARNING : be careful to white-space and lines break in FreeMarker macros.
 # This macro template can be used to output white-space-sensitive formats (like RSS files).
 # See http://dev.lutece.paris.fr/jira/browse/LUTECE-765
-->
<#include "util/calendar/macro_datepicker.ftl"  ignore_missing=true />
<#-- Do not remove this comment -->

<#-- Information about this commons file -->
<#macro commonsFile>commons_bulma.ftl</#macro>
<#macro commonsName>Commons Bulma 0.7.2</#macro>
<#macro commonsDescription>Freemarker Commons macros powered by Bulma CSS Framework v0.7.2</#macro>


<#macro coreAdminCSSLinks>
<link href="css/admin/style/bulma/bulma.min.css"  rel="stylesheet" > <!-- provided by core -->
<link href="css/admin/style/bulma/bulma-accordion.min.css"  rel="stylesheet" > <!-- provided by core -->
<link href="css/admin/jquery-ui.min.css"  rel="stylesheet" > <!-- provided by core -->
<link href="css/admin/jquery-ui.structure.min.css"  rel="stylesheet" > <!-- provided by core -->
<link href="css/admin/jquery-ui.theme.min.css"  rel="stylesheet" > <!-- provided by core -->
<link href="css/admin/font-awesome.min.css"  rel="stylesheet" > <!-- provided by core -->
<link href="css/admin/ionicons.min.css"  rel="stylesheet" > <!-- provided by core -->
<link href="css/admin/skins/_all-skins.min.css"  rel="stylesheet" > <!-- provided by core -->
<link href="css/admin/portal_admin.css"  rel="stylesheet" > <!-- provided by core -->
</#macro>

<#macro coreAdminJSLinks>
<script src="js/admin/style/bulma/bulma-accordion.min.js"></script> <!-- provided by core -->
<script src="js/jquery/jquery-ui.min.js"></script> <!-- provided by core -->
<script src="js/admin.js"></script> <!-- provided by core -->
</#macro>

<#global gClassActive='is-active' />


<#macro comboWithParams name default_value additionalParameters items >
<div class="select">
    <select id="${name}" name="${name}" ${additionalParameters}>
    <#list items as item>
        <#if default_value="${item.code}">
            <option selected="selected" value="${item.code}" >${item.name}</option>
        <#else>
            <option value="${item.code}" >${item.name}</option>
        </#if>
    </#list>
    </select>
</div>    
</#macro>

<#macro comboSortedWithParams name default_value additionalParameters items id=name>
<div class="select">
    <select id="${id}" name="${name}" ${additionalParameters}>
    <#list items?sort_by("name") as item>
        <#if default_value="${item.code}">
            <option selected="selected" value="${item.code}" <#if !item.name?has_content>label="${i18n("portal.util.labelEmpty")}"</#if>>${item.name}</option>
        <#else>
            <option value="${item.code}" <#if !item.name?has_content>label="${i18n("portal.util.labelEmpty")}"</#if>>${item.name}</option>
        </#if>
    </#list>
    </select>
</div>
</#macro>

<#macro comboWithParamsAndLength name default_value additionalParameters items max_length class=''>
<div class="select">
    <select id="${name}" name="${name}" ${additionalParameters}>
		<#list items as item>
    	    <#if max_length < item.name?length >
            	<#assign item_new = "..." + "${item.name?substring(item.name?length-max_length+3)}" >
            <#else>
              	<#assign item_new = "${item.name}">
            </#if>
			<#if default_value="${item.code}">
      			<option selected="selected" value="${item.code}" >${item_new}</option>
      		<#else>
      			<option value="${item.code}" >${item_new}</option>
      		</#if>
    	</#list>
	</select>
</div>
</#macro>

<#macro combo name default_value items >
	<@comboWithParams name="${name}" default_value="${default_value}" additionalParameters="" items=items />
</#macro>

<#macro comboSorted name default_value items >
	<@combo name="${name}" default_value="${default_value}" items=items?sort_by("name") />
</#macro>


<#macro radioImageList name default_value items inline=0>
<#if inline=1>
	<#list items as item>
		<label for="${name}" class="radio-inline">
			<input <#if default_value="${item.code}">checked="checked"</#if> class="radio" type="radio" name="${name}" value="${item.code}">
			<img src="${item.name}" alt="${item.name}" title="${item.name}">
		</label>
	</#list>
<#else>
	<#list items as item>
		<div class="radio">
			<label for="${name}">
				<input <#if default_value="${item.code}">checked="checked"</#if> class="radio" type="radio" name="${name}" value="${item.code}">
				<img src="${item.name}" alt="${item.name}" title="${item.name}">
			</label>
		</div>
	</#list>
</#if>
</#macro>

<#macro checkboxList name default_values items inline=0>
<#if inline=1>
	<#list items as item>
		<label for="${name}" class="checkbox-inline">
			<input <#if item.checked >checked</#if> class="checkbox" type="checkbox" name="${name}" value="${item.code}" />&nbsp;${item.name}
		</label>
	</#list>
 <#else>
	<#list items as item>
		<#if item.checked >
			<div class="checkbox">
			<label for="document_type"><input checked class="checkbox" type="checkbox" name="${name}" value="${item.code}" />&nbsp;${item.name}</label>
			</div>
		<#else>
			<div class="checkbox">
			<label for="document_type"><input class="checkbox" type="checkbox" name="${name}" value="${item.code}" />&nbsp;${item.name}</label>
			</div>
		</#if>
	</#list>
</#if>
</#macro>

<#macro sort jsp_url attribute id="" >
	<#if jsp_url?contains("?")>
		<#assign sort_url = jsp_url + "&amp;sorted_attribute_name=" + attribute + "&amp;asc_sort=" />
	<#else>
		<#assign sort_url = jsp_url + "?sorted_attribute_name=" + attribute + "&amp;asc_sort=" />
	</#if>
	<div class="field is-grouped" role="group" aria-label="sortButton">
		<a class="button is-default is-small" id="sort${id!}_${attribute!}" href="${sort_url}true#sort${id!}_${attribute!}" title="#i18n{portal.util.sort.asc}" >
            <span class="icon"><i class="fa fa-chevron-up"></i></span>
		</a>
		<a class="button is-default is-small" href="${sort_url}false#sort${id!}_${attribute!}" title="#i18n{portal.util.sort.desc}">
			<span class="icon"><i class="fa fa-chevron-down"></i>
		</a>
	</div>
</#macro>

<#macro pagination paginator >
	<#assign nbLinkPagesToDisplay = 10 />
	<#assign offsetPrev = nbLinkPagesToDisplay / 2 />
	<#assign offsetNext = nbLinkPagesToDisplay / 2 />
	<#if ( paginator.pageCurrent <= nbLinkPagesToDisplay - offsetPrev )>
		<#assign offsetPrev = paginator.pageCurrent - 1 />
		<#assign offsetNext = nbLinkPagesToDisplay - offsetPrev />
	<#elseif ( paginator.pageCurrent + offsetNext > paginator.pagesCount )>
		<#assign offsetNext = paginator.pagesCount - paginator.pageCurrent />
		<#assign offsetPrev = nbLinkPagesToDisplay - offsetNext />
	</#if>

<#if ( paginator.pagesCount > 1 )>
	<#if ( paginator.pageCurrent - offsetPrev > 1 )>
		<a href="${paginator.firstPageLink?xhtml}">
			<span class="icon"><i class="fa fa-angle-double-left"></i></span>&nbsp;#i18n{portal.util.labelFirst}
		</a>
	</#if>
	<#if ( paginator.pageCurrent > 1 )>
		<a href="${paginator.previousPageLink?xhtml}">
			<span class="icon"><i class="fa fa-angle-left"></i></span>&nbsp;#i18n{portal.util.labelPrevious}
		</a>
	<#else>
		&nbsp;&nbsp;
	</#if>
	<#if ( paginator.pageCurrent - offsetPrev > 1 )>
		<strong>...</strong>
	</#if>
	<#list paginator.pagesLinks as link>
		<#if link.index == paginator.pageCurrent>
			<strong>${link.name}</strong>
		<#else>
			<a href="${link.url?xhtml}">${link.name}</a>
		</#if>
	</#list>
	<#if ( paginator.pageCurrent + offsetNext < paginator.pagesCount )>
		<strong>...</strong>
	</#if>
	<#if ( paginator.pageCurrent < paginator.pagesCount )>
		<a href="${paginator.nextPageLink?xhtml}">
            <span class="icon"><i class="fa fa-angle-right"></i></span>&nbsp;#i18n{portal.util.labelNext}
		</a>
		<#if ( paginator.pageCurrent + offsetNext < paginator.pagesCount )>
			<a href="${paginator.lastPageLink?xhtml}">
				<span class="icon"><i class="fa fa-angle-double-right"></i></span>&nbsp;#i18n{portal.util.labelLast}
			</a>
		</#if>
	<#else>
		&nbsp;&nbsp;
	</#if>
</#if>
</#macro>


<#macro paginationAdmin paginator combo=0 form=1 nb_items_per_page=nb_items_per_page showcount=1 showall=0>
		<#if (paginator.pagesCount > 1) >
			<@paginationPageLinks paginator=paginator />
		</#if>
		<div class="pull-right">
			<#if form == 1 >
				<form method="post" class="form-inline">
			</#if>
			<@paginationItemCount paginator=paginator combo=combo nb_items_per_page=nb_items_per_page showcount=showcount showall=showall/>
			<#if form == 1 >
				</form>
			</#if>
		</div>
 </#macro>

<#macro paginationPageLinks paginator >
<#assign nbLinkPagesToDisplay = 10 />
<#assign offsetPrev = nbLinkPagesToDisplay / 2 />
<#assign offsetNext = nbLinkPagesToDisplay / 2 />
<#if ( paginator.pageCurrent <= nbLinkPagesToDisplay - offsetPrev )>
	<#assign offsetPrev = paginator.pageCurrent - 1 />
	<#assign offsetNext = nbLinkPagesToDisplay - offsetPrev />
<#elseif ( paginator.pageCurrent + offsetNext > paginator.pagesCount )>
	<#assign offsetNext = paginator.pagesCount - paginator.pageCurrent />
	<#assign offsetPrev = nbLinkPagesToDisplay - offsetNext />
</#if>
<ul class="pagination pagination-sm">
<#if ( paginator.pageCurrent - offsetPrev > 1 )>
	<li>
		<a href="${paginator.firstPageLink?xhtml}">
			${paginator.labelFirst}
		</a>
	</li>
</#if>
<#if (paginator.pageCurrent > 1) >
	<li class="previous">
		<a href="${paginator.previousPageLink?xhtml}">
			${paginator.labelPrevious}
		</a>
	</li>
<#else>
	<li class="disabled">
		<a href="${paginator.firstPageLink?xhtml}">${paginator.labelPrevious}</a>
	</li>
</#if>
<#if ( paginator.pageCurrent - offsetPrev > 1 )>
	<li>
		<a href="${(paginator.pagesLinks?first).url?xhtml}"><strong>...</strong></a>
	</li>
</#if>
<#list paginator.pagesLinks as link>
	<#if ( link.index == paginator.pageCurrent )>
		<li class="active">
			<a href="${link.url?xhtml}">${link.name}</a>
		</li>
	<#else>
		<li>
			<a href="${link.url?xhtml}">${link.name}</a>
		</li>
	</#if>
</#list>
<#if ( paginator.pageCurrent + offsetNext < paginator.pagesCount )>
	<li>
		<a href="${(paginator.pagesLinks?last).url?xhtml}"><strong>...</strong></a>
	</li>
</#if>
<#if (paginator.pageCurrent < paginator.pagesCount) >
	<li class="next">
		<a href="${paginator.nextPageLink?xhtml}">
			${paginator.labelNext}
		</a>
	</li>
	<#if ( paginator.pageCurrent + offsetNext < paginator.pagesCount )>
		<li class="next">
			<a href="${paginator.lastPageLink?xhtml}">
				${paginator.labelLast}
			</a>
		</li>
	</#if>
<#else>
	<li class="disabled">
		<a href="${paginator.lastPageLink?xhtml}">${paginator.labelNext}</a>
	</li>
</#if>
</ul>
 </#macro>

<#macro paginationCombo paginator nb_items_per_page=nb_items_per_page showall=0>
	<label>${paginator.labelItemCountPerPage}</label>
  <div class="input-group">
      <div class="select is-rounded is-small">
	  <select data-max-item="${paginator.itemsCount}" name="${paginator.itemsPerPageParameterName}" id="${paginator.itemsPerPageParameterName}" title="${paginator.labelItemCountPerPage}">
  		<#list [ "10" , "20" , "50" , "100" ] as nb>
  			<#if nb_items_per_page = nb >
  				<option selected="selected" value="${nb}">${nb}</option>
  			<#else>
  				<option value="${nb}">${nb}</option>
  			</#if>
  		</#list>
  		<#if showall ==1>
  			<#if paginator.itemsCount &gt; 100 >
  				<option <#if nb_items_per_page?number = paginator.itemsCount?number >selected="selected"</#if> value="${paginator.itemsCount}" class="${nb_items_per_page}">#i18n{portal.util.labelAll}</option>
  			</#if>
  		</#if>
	  </select>
      </div>
	  <span class="input-group-btn">
		<button class="button is-default is-small" type="submit" title="#i18n{portal.util.labelRefresh}">
            <span class="icon"><i class="fa fa-repeat"></i></span>
		</button>
	</span>
</div>
</#macro>

<#macro paginationItemCount paginator combo=0 nb_items_per_page=nb_items_per_page showcount=1 showall=0>
<#-- Display combo -->
<#if combo == 1 >
  <@paginationCombo paginator=paginator nb_items_per_page=nb_items_per_page showall=showall />
</#if>
<#-- Display item count -->
<#if showcount == 1 >
<span class="showcount">
	<#if (paginator.labelItemCount)?? && paginator.labelItemCount?has_content>&nbsp;-&nbsp;${paginator.labelItemCount} : </#if> ${paginator.itemsCount}
</span>
</#if>
</#macro>

<#macro item_navigation item_navigator id="item-navigator">
<nav id="${id}" style="display:inline;">
<#if (item_navigator.currentItemId > 0)>
	<@aButton size='' href='${item_navigator.previousPageLink?xhtml}' title='#i18n{portal.util.labelPrevious}' buttonIcon='arrow-left' color='info' hideTitle=['xs','sm'] />
</#if>
<#if (item_navigator.currentItemId < item_navigator.listItemSize - 1) >
	<@aButton size='' href='${item_navigator.nextPageLink?xhtml}' title='#i18n{portal.util.labelNext}' buttonIcon='arrow-right' color='info' hideTitle=['xs','sm'] />
</#if>
</nav>
</#macro>

<#--
MACRO DEPRECATED SET
This is now empty because it should not be used anymore
and is kept only for backwards compatibility
-->

<#macro dataTable dataTableManager actionMacro="" tableClass="table table-striped table-condensed" caption="&nbsp;" summary="data table" >
	<#if 0 < dataTableManager.items?size >
		<#if dataTableManager.enablePaginator>
			<form class="form-inline" method="post" action="${dataTableManager.sortUrl}">
			    <#if (dataTableManager.paginator.pagesCount > 1) >
			        <@paginationPageLinks paginator=dataTableManager.paginator />
			    </#if>
			    <div class="pull-right">
					<@paginationItemCount paginator=dataTableManager.paginator combo=1 nb_items_per_page=dataTableManager.paginator.itemsPerPage?string />
				</div>
				<input type="hidden" name="${dataTableManager.id}" id="${dataTableManager.id}" value="${dataTableManager.id}" />
			</form>
		</#if>
		<table class="${tableClass}" summary="${summary}">
			<caption>${caption}</caption>
			<tr>
				<#list dataTableManager.listColumn as column>
					<th scope="col">
						#i18n{${column.titleKey}}
						<#if !(column.typeColumn = "ACTION") && column.sortable>
							<@sort jsp_url=dataTableManager.sortUrl attribute=column.parameterName />
						</#if>
					</th>
				</#list>
			</tr>
			<#list dataTableManager.items as item>
				<tr>
					<#list dataTableManager.listColumn as column>
						<#if column.typeColumn = "STRING">
							<#assign propName = "item." + column.parameterName>
							<#assign value = propName?eval>
							<td>${value!}</td>
						<#elseif column.typeColumn = "LABEL">
							<#assign propName = "item." + column.parameterName>
							<#assign value = propName?eval>
							<td>#i18n{${value!}}</td>
						<#elseif column.typeColumn = "BOOLEAN">
							<#assign propName = "item." + column.parameterName>
							<#assign value = propName?eval>
							<#if value?? && value>
								<td><span class="label label-success" title="#i18n{${column.labelTrue!}}"><i class="glyphicon glyphicon-ok-sign icon-white"></i>#i18n{${column.labelTrue!}}</span></td>
							<#else>
								<td><span class="label label-important" title="#i18n{${column.labelFalse!}}"><i class="glyphicon glyphicon-remove-sign icon-white"></i>#i18n{${column.labelFalse!}}</span></td>
							</#if>
						<#elseif column.typeColumn = "EMAIL">
							<#assign propName = "item." + column.parameterName>
							<#assign value = propName?eval>
							<td><#if value?? && value != ""><a href="mailto:${value}" title="${value}" >${value}</a></#if></td>
						<#elseif column.typeColumn = "ACTION">
							<#if column.parameterName?? && column.parameterName != "">
								<#assign macroName = column.parameterName>
							<#elseif actionMacro?? && actionMacro != "">
								<#assign macroName = actionMacro>
							</#if>
							<#if macroName?? && macroName != "">
								<td><@.vars[macroName] item=item /></td>
							</#if>
						</#if>
					</#list>
				</tr>
			</#list>
		</table>
		<#if dataTableManager.enablePaginator>
			<form class="form-inline" method="post" action="${dataTableManager.sortUrl}">
			    <#if (dataTableManager.paginator.pagesCount > 1) >
			        <@paginationPageLinks paginator=dataTableManager.paginator />
			    </#if>
			    <div class="pull-right">
					<@paginationItemCount paginator=dataTableManager.paginator combo=0 nb_items_per_page=dataTableManager.paginator.itemsPerPage?string />
				</div>
				<input type="hidden" name="${dataTableManager.id}" id="${dataTableManager.id}" value="${dataTableManager.id}" />
			</form>
		</#if>
	<#else>
		#i18n{portal.util.labelNoItem}
	</#if>
</#macro>

<#macro filterPanel dataTableManager formClass="form-horizontal" >
	<#if dataTableManager.filterPanel.listFilter?? && 0 < dataTableManager.filterPanel.listFilter?size>
		<form class="${formClass}" method="post" action="${dataTableManager.filterPanel.formUrl}" >
			<fieldset>
				<#list dataTableManager.filterPanel.listFilter as filter>
					<div class="field is-horizontal">
						<label class="col-xs-12 col-sm-3 col-md-3" for="description" >#i18n{${filter.filterLabel}} :</label>
						<div class="col-xs-12 col-sm-9 col-md-9">
							<#if filter.filterType = "STRING">
								<input type="text" name="${dataTableManager.filterPanelPrefix}${filter.parameterName}" id="${filter.parameterName}" size="30" value="${filter.value!}"/>
							<#elseif filter.filterType = "BOOLEAN">
								<input type="checkbox" value="true" name="${dataTableManager.filterPanelPrefix}${filter.parameterName}" id="${dataTableManager.filterPanelPrefix}${filter.parameterName}" <#if filter.value?? && filter.value = "true">checked="checked" </#if>/>
							<#elseif filter.filterType = "DROPDOWNLIST">
								<#if filter.value??>
									<#assign filter_value = filter.value >
								<#else>
									<#assign filter_value = "" >
								</#if>
								<@combo name=dataTableManager.filterPanelPrefix+filter.parameterName default_value=filter_value items=filter.refList />
							</#if>
						</div>
					</div>
				</#list>
				<div class="field is-horizontal">
					<input type="hidden" name="${dataTableManager.filterPanelPrefix}updateFilters" id="${dataTableManager.filterPanelPrefix}updateFilters" value="true" />
					<input type="hidden" name="${dataTableManager.id}" id="${dataTableManager.id}" value="${dataTableManager.id}" />
					<button class="button is-primary is-medium" type="submit" >
						<span class="icon"><i class="fa fa-search"></i></span>
						<span class="hidden-xs" >#i18n{portal.util.labelSearch}</span>
					</button>
					<#if dataTableManager.filterPanel.formUrl?contains("?")>
						<#assign dataTableResetUrl = dataTableManager.filterPanel.formUrl + "&" + dataTableManager.filterPanelPrefix + "resetFilters=true" />
					<#else>
						<#assign dataTableResetUrl = dataTableManager.filterPanel.formUrl + "?" + dataTableManager.filterPanelPrefix + "resetFilters=true" />
					</#if>
					<a class="button is-primary is-medium" href="${dataTableResetUrl}" title="#i18n{portal.util.labelReset}">
                        <span class="icon"><i class="fa fa-remove-circle"></i></span>
						<span class="hidden-xs" >#i18n{portal.util.labelReset}</span>
					</a>
				</div>
			</fieldset>
		</form>
	</#if>
</#macro>

<#macro fieldInputText i18nLabelKey inputName mandatory=false value="" maxlength=0 i18nHelpBlockKey='' cssClass='input field-body'>
<div class="field is-horizontal">
	<label class="field-label" for="${inputName}">#i18n{${i18nLabelKey}}&nbsp;<#if mandatory>*</#if>&nbsp;:</label>
	<p class="control">
		<input class="${cssClass}" id="${inputName}" name="${inputName}" type="text" value="${value}" <#if maxlength &gt; 0>maxlength=${maxlength}</#if> />
	</p>
	<#if i18nHelpBlockKey != ''><p class="help-block">#i18n{${i18nHelpBlockKey}}</p></#if>
</div>
</#macro>

<#macro fieldInputPassword i18nLabelKey inputName mandatory=false value="" maxlength=0 i18nHelpBlockKey='' cssClass='input field-body'>
<div class="field is-horizontal">
	<label class="field-label" for="${inputName}">#i18n{${i18nLabelKey}}&nbsp;<#if mandatory>*</#if>&nbsp;:</label>
	<div class="control">
		<input class="${cssClass}" id="${inputName}" name="${inputName}" type="password" value="${value}" <#if maxlength &gt; 0>maxlength=${maxlength}</#if>>
		<#if i18nHelpBlockKey != ''><p class="help-block">#i18n{${i18nHelpBlockKey}}</p></#if>
	</div>
</div>
</#macro>

<#macro fieldInputWrapper i18nLabelKey inputName mandatory=false value="" maxlength=0 i18nHelpBlockKey='' cssClass='input field-body'>
<div class="field is-horizontal">
	<label class="field-label" for="${inputName}">#i18n{${i18nLabelKey}}&nbsp;<#if mandatory>*</#if>&nbsp;:</label>
	<div class="control">
		<#nested>
		<#if i18nHelpBlockKey != ''><p class="help-block">#i18n{${i18nHelpBlockKey}}</p></#if>
	</div>
</div>
</#macro>

<#macro fieldStaticText i18nLabelKey cssClass='input' >
<div class="field is-horizontal">
	<label class="field-label">#i18n{${i18nLabelKey}}&nbsp; :</label>
	<div class="control">
				<p class="field-static">
		<#nested>
				</p>
	</div>
</div>
</#macro>

<#macro fieldInputCalendar i18nLabelKey inputName mandatory=false value="" i18nHelpBlockKey='' cssClass='input' language='fr'>
<div class="field is-horizontal">
	<label class="field-label" for="${inputName}">#i18n{${i18nLabelKey}}&nbsp;<#if mandatory>*</#if>&nbsp;:</label>
	<div class="control">
		<div class="input-group">
			<div class="input-group-addon"><span class="icon"><i class="fa fa-calendar">&nbsp;</i></span></div>
			<input class="${cssClass}" id="${inputName}" name="${inputName}" type="text" value="${value}" >
		</div>
		<#if i18nHelpBlockKey != ''><p class="help-block">#i18n{${i18nHelpBlockKey}}</p></#if>
	</div>
</div>
<@getDatePickerBootstrap idField=inputName language=language />
</#macro>

<#macro fieldInputCheckBox i18nLabelKey inputName value="" disabled=false checked=false i18nHelpBlockKey='' cssClass='' >
<div class="field is-horizontal">
	<div class="col-xs-12 col-sm-offset-3 col-sm-6 col-md-offset-3 col-md-6 col-lg-offset-3 col-lg-6">
		<div class="checkbox<#if disabled> disabled</#if> ">
			<label>
				<input class="${cssClass}" id="${inputName}" name="${inputName}" type="checkbox" value="${value}" <#if checked>checked</#if> <#if disabled>disabled</#if> >
				#i18n{${i18nLabelKey}}
			</label>
		</div>
		<#if i18nHelpBlockKey != ''><p class="help-block">#i18n{${i18nHelpBlockKey}}</p></#if>
	</div>
</div>
</#macro>

<#macro fieldInputRadioBox i18nLabelKey inputName value="" disabled=false checked=false i18nHelpBlockKey='' cssClass='' >
<div class="field is-horizontal">
	<div class="col-xs-12 col-sm-offset-3 col-sm-6 col-md-offset-3 col-md-6 col-lg-offset-3 col-lg-6">
		<div class="radio<#if disabled> disabled</#if> ">
			<label>
				<input class="${cssClass}" id="${inputName}" name="${inputName}" type="radio" value="${value}" <#if checked>checked</#if> <#if disabled>disabled</#if> >
				#i18n{${i18nLabelKey}}
			</label>
		</div>
		<#if i18nHelpBlockKey != ''><p class="help-block">#i18n{${i18nHelpBlockKey}}</p></#if>
	</div>
</div>
</#macro>

<#macro fieldInputCheckBoxInline inputName value="" disabled=false checked=false >
<label class="checkbox-inline<#if disabled> disabled</#if> ">
	<input class="${cssClass}" id="${inputName}" name="${inputName}" type="checkbox" value="${value}" <#if checked>checked</#if> <#if disabled>disabled</#if> > #i18n{${i18nLabelKey}}
</label>
</#macro>

<#macro fieldInputRadioBoxInline inputName value="" disabled=false checked=false >
<label class="radio-inline<#if disabled> disabled</#if> ">
	<input class="${cssClass}" id="${inputName}" name="${inputName}" type="radio" value="${value}" <#if checked>checked</#if> <#if disabled>disabled</#if> > #i18n{${i18nLabelKey}}
</label>
</#macro>

<#macro fieldInputCombo i18nLabelKey inputName items value="" mandatory=false i18nHelpBlockKey='' cssClass='input' >
<div class="field is-horizontal">
	<label class="field-label" for="${inputName}">#i18n{${i18nLabelKey}}&nbsp;<#if mandatory>*&nbsp;</#if>:</label>
	<div class="control">
		<#assign params = "class='" + cssClass + "'" >
		<@comboWithParams name=inputName items=items default_value=value additionalParameters=params />
		<#if i18nHelpBlockKey != ''><p class="help-block">#i18n{${i18nHelpBlockKey}}</p></#if>
	</div>
</div>
</#macro>

<#macro fieldTextArea i18nLabelKey inputName mandatory=false value="" maxlength=0 i18nHelpBlockKey='' cssClass='input'>
<div class="field is-horizontal">
	<label class="field-label" for="${inputName}">#i18n{${i18nLabelKey}}&nbsp;<#if mandatory>*</#if>&nbsp;:</label>
	<div class="control">
		<textarea class="${cssClass}" id="${inputName}" name="${inputName}" <#if maxlength &gt; 0>maxlength=255</#if> >${value}</textarea>
		<#if i18nHelpBlockKey != ''><p class="help-block">#i18n{${i18nHelpBlockKey}}</p></#if>
	</div>
</div>
</#macro>

<#macro actionButtons button1Name='' button2Name='' i18nValue1Key='portal.admin.message.buttonValidate' i18nValue2Key='portal.admin.message.buttonCancel' url1='' url2='' icon1='fa fa-check' icon2='fa fa-close' offset=3 >
<#assign col = 11 - offset />
<div class="field is-horizontal">
<#if url1 != ''>
	<a class="button is-primary" href="${url1}"  >
		<i class="${icon1}"></i>&nbsp;#i18n{${i18nValue1Key}}
	</a>
<#else>
	<button  class="button is-primary" name="${button1Name}" type="submit">
		<i class="${icon1}"></i>&nbsp;#i18n{${i18nValue1Key}}
	</button>
</#if>
<#if url2 != ''>
	<a class="button is-default" href="${url2}"  >
		<i class="${icon2}"></i>&nbsp;#i18n{${i18nValue2Key}}
	</a>
<#else>
	<#if button2Name != ''>
		<button class="button is-default" name="${button2Name}" type="submit" >
			<i class="${icon2}"></i>&nbsp;#i18n{${i18nValue2Key}}
		</button>
	</#if>
</#if>
</div>
</#macro>

<#macro boxSized col i18nTitleKey boxClass='box-primary' >
<div class="col-md-${col}">
	<div class="box ${boxClass}">
		<@boxHeader title=i18nTitleKey />
		<div class="box-body">
			<#nested>
		</div>
	</div>
</div>
</#macro>

<#macro rowBox boxClass='box-primary' col=12>
<div class="columns">
    <div class="column">
        <div class="card">
            <#nested>
        </div>
    </div>
</div>
</#macro>

<#--
<#macro rowBoxHeader i18nTitleKey boxClass='box-primary' col=12>
<@rowBox boxClass=boxClass col=col >
    <@boxHeader i18nTitleKey=i18nTitleKey />
    <div class="card-header">
        <#nested>
    </div>
</@rowBox>
</#macro>

<#macro headerButtons>
<#nested>
</#macro>

-->




<#macro messages errors=[] infos=[] warnings=[] errors_class="alert alert-danger" infos_class="alert alert-info" warnings_class="alert alert-warning">
<#if errors??>
	<#if errors?size &gt; 0 >
		<div class="notification is-danger" id="messages_errors_div">
			<button class="delete"></button>
			<#list errors as error >
				<span class="icon"><i class="fa fa-exclamation-circle"></i></span> ${error.message} <br>
			</#list>
		</div>
	</#if>
</#if>
<#if infos??>
	<#if infos?size &gt; 0 >
		<div class="notification is-info" id="messages_infos_div" >
			<button class="delete"></button>
			<#list infos as info >
				<span class="icon"><i class="fa fa-info-circle"></i></span> ${info.message} <br>
			</#list>
		</div>
	</#if>
</#if>
<#if warnings??>
	<#if warnings?size &gt; 0 >
		<div class="${warnings_class}" id="messages_warnings_div" >
			<a class="delete" data-dismiss="alert" href="#">x</a>
			<#list warnings as warning >
				<span class="icon"><i class="fa fa-info-circle"></i></span> ${warning.message} <br>
			</#list>
		</div>
	</#if>
</#if>
</#macro>

<#---------------------------NEW MACROS------------------------------>
	
<#-- TABLE -->
<#-- class:  -->
<#macro table responsive=true condensed=true hover=true striped=false bordered=false narrow=false class='' id='' params=''>

    <#assign tableClass=class />
    <#if condensed> <#assign tableClass=tableClass + ' is-narrow' /> </#if>
    <#if hover> <#assign tableClass=tableClass + ' is-hoverable' /> </#if>
    <#if striped>   <#assign tableClass=tableClass + ' is-striped'   /> </#if>
    <#if bordered>  <#assign tableClass=tableClass + ' is-bordered'  /> </#if>
    
    <table class="table is-fullwidth ${tableClass}" id="${id}"<#if params!=''> ${params}</#if>>
        <#nested>
    </table>
</#macro>

<#macro tableHeadBodySeparator>
</thead>
<tbody>
</#macro>

<#-- MACRO TR -->
<#macro tr>
	<tr>
    <#nested>
	</tr>
</#macro>

<#-- MACRO TH -->
<#macro th id='' class='' hide=[] showXs=true showSm=true showMd=true showLg=true showXl=true cols=0 xs=0 sm=0 md=0 lg=0 xl=0 flex=false params=''>
    <#local class += displaySettings(hide,'is-inline') />
		<th <#if class != ''>class="${class}"</#if>>
        <#nested>
    </th>
</#macro>

<#-- MACRO TD -->
<#macro td id='' class='' hide=[] showXs=true showSm=true showMd=true showLg=true showXl=true xs=0 sm=0 md=0 lg=0 xl=0 flex=false params=''>
    <#local class += displaySettings(hide,'is-inline') />
		<td class="<#if class != ''>${class}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
			<#if flex><div style="display:flex;"></#if>
			<#nested>
			<#if flex></div></#if>
		</td>
</#macro>

<#--- MACRO SELECT (TO REPLACE "COMBO" MACROS) --->
<#macro select name items='' default_value="" id=name class='' size='' sort=false multiple=0 params='' title='' tabIndex=0>
	<#switch size>
		<#case 'xs'>
				<#assign selectSize='small'>
				<#break>
		<#case 'sm'>
				<#assign selectSize='small'>
				<#break>
		<#case 'md'>
				<#assign selectSize='medium'>
				<#break>
		<#case 'lg'>
				<#assign selectSize='large'>
				<#break>
		<#default>
				<#assign selectSize='normal'>
	</#switch>
<div class="select<#if selectSize!=''> is-${selectSize}</#if>">
    <select id="${id}" name="${name}" class="field<#if class!=''> input-${class}</#if>" <#if (multiple &gt; 0)>multiple size="${multiple}"</#if><#if (tabIndex &gt; 0)> tabindex="${tabIndex}"</#if><#if params!=''> ${params}</#if><#if title!=''> ${title}</#if><#if mandatory?? && mandatory> required</#if>>
    <#if items?has_content>
        <#if sort=true>
            <#list items?sort_by("name") as item>
                <#if default_value="${item.code}">
                    <option selected="selected" value="${item.code}" <#if !item.name?has_content>label="${i18n("portal.util.labelEmpty")}"</#if>>${item.name}</option>
                <#else>
                    <option value="${item.code}" <#if !item.name?has_content>label="${i18n("portal.util.labelEmpty")}"</#if>>${item.name}</option>
                </#if>
            </#list>
        <#else>
            <#list items as item>
                <#if default_value="${item.code}">
                    <option selected="selected" value="${item.code}" <#if !item.name?has_content>label="${i18n("portal.util.labelEmpty")}"</#if>>${item.name}</option>
                <#else>
                    <option value="${item.code}" <#if !item.name?has_content>label="${i18n("portal.util.labelEmpty")}"</#if>>${item.name}</option>
                </#if>
            </#list>
        </#if>
    <#else>
        <#nested>
    </#if>
    </select>
</div>
</#macro>

<#-- ICONS -->
<#-- Icons from FontAwesome -->
<#macro icon prefix='fa-' style='' class='' title='' id='' params=''>
<#if style='docker' || style = 'github' || style='gitlab' || style='java' || style='jira' || style='jenkins' || style = 'twitter' >
	<#local prefix = 'fab ' + prefix />
<#else>
	<#local prefix = 'fa ' + prefix />
</#if>
	<i class="${prefix}${style}<#if class!=''> ${class}</#if>" aria-hidden="true"<#if title!=''> title='${title}'</#if><#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>></i>
</#macro>

<#-- FORM -->
<#-- type: inline/horizontal/form -->
<#macro tform type='horizontal' class='' align='' hide=[] action='' method='post' name='' id='' role='form' params=''>
	<#assign formClass = alignmentSettings(align) + ' ' + class />
	<#switch type>
		<#case 'horizontal'>
		<#assign formClass += ' form-horizontal'>
		<#break>

		<#case 'inline'>
		<#assign formClass += ' form-inline'>
		<#break>
		
		<#default>
		<#assign formClass += ' form'>
	</#switch>

<form class="<#if formClass!=''>${formClass?trim}</#if>"<#if id!=''> id="${id}"</#if><#if action!=''> action="${action}"</#if><#if method!=''> method="${method}"</#if><#if name!=''> name="${name}"</#if><#if role!=''> role="${role}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</form>
</#macro>

<#-- FORM ELEMENT STRUCTURE -->
<#-- formStyle values: empty/inline/horizontal/navbar-form/navbar-left... Default is horizontal -->
<#-- groupStyle: is-success/is-danger/is-warning... -->

<#macro formGroup formStyle='horizontal' class='' groupStyle='' rows=1 labelKey='' labelFor='' labelId='' helpKey='' id='' mandatory=false hideLabel=[] params=''>
<#local labelDisplayClass = displaySettings(hideLabel,'') />
<div class="field is-horizontal">
  <div class="field-label<#if labelDisplayClass!=''> ${labelDisplayClass}</#if>">
    <label class="label">${labelKey} <#if mandatory=true>*</#if></label>
  </div>
  <div class="field-body">
    <div class="field">
   		<#assign mandatory = mandatory>
   		<#nested>
        <#if helpKey != ''><p class="help">${helpKey}</p></#if>
    </div>
  </div>
</div>

</#macro>

<#macro formField class=''>
<div class="control ${class}">
	<#nested>
</div>
</#macro>

<#macro formLabel class='' labelFor='' labelId='' labelKey='' hideLabel=[] mandatory=true>
	<#local labelDisplayClass = displaySettings(hideLabel,'') />
	<label class="<#if class !=''>${class}</#if> ${labelDisplayClass}" for="${labelFor}" <#if labelId!=''> id="${labelId}"</#if><#if mandatory=true>ariaLabel="${labelKey} [#i18n{portal.users.modify_attribute.labelMandatory}]"</#if>>${labelKey}</label>
</#macro>

<#macro formHelp style='inline' class='' labelFor=''>
<p class="help<#if class!=''> ${class}</#if>" <#if labelFor!=''>id="${labelFor}_help"</#if>>
	<#nested>
</p>
</#macro>

<#-- INPUT TEXT/TEXTAREA/SEARCH/PASSWORD/EMAIL/FILE -->
<#-- type : text/textarea/password/email/file/number. Default is text -->
<#-- size: xs/sm/lg -->
<#-- pattern: [A-F][0-9]{5} -->
<#macro input name type='text' value='' class='' size='' inputSize=0 maxlength=0 placeHolder='' rows=4 cols=40 richtext=false tabIndex='' id='' disabled=false readonly=false pattern='' params='' title='' min=0 max=0>
<#if size == 'xs' || size == 'sm'><#local size = 'small' />
<#elseif size == 'md'><#local size = 'medium' />
<#elseif size == 'lg'><#local size = 'large' />
<#else><#local size = '' /></#if>
<#if type != 'hidden'>
<div class="control">
</#if>
<#if type='textarea'>
	<textarea name="${name}" class="textarea <#if size!=''> is-${size}</#if><#if class!=''> ${class}</#if><#if richtext> richtext</#if>" rows="${rows}" cols="${cols}"<#if tabIndex!=''> tabindex="${tabIndex}"</#if><#if placeHolder!=''> placeholder="${placeHolder}"</#if><#if title!=''> title="${title}"</#if><#if disabled> disabled</#if><#if readonly> readonly</#if><#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if><#if pattern!=''>pattern=${pattern}</#if><#if mandatory?? && mandatory && !richtext> required</#if><#if labelFor?? && labelFor!='' && helpKey?? && helpKey!=''> aria-describedby="${labelFor}_help"</#if>><#nested></textarea>
<#elseif type='text' || type='search' || type='password' || type='email' || type='file' || type='number'>
    <input class="input<#if size!=''> is-${size}</#if><#if class!=''> ${class}</#if>" name="${name}" type="${type}" value="${value}"<#if tabIndex!=''> tabindex="${tabIndex}"</#if><#if placeHolder!=''> placeholder="${placeHolder}"</#if><#if title!=''> title="${title}"</#if><#if maxlength &gt; 0> maxlength="${maxlength}"</#if><#if inputSize!=0> size="${inputSize}"</#if><#if disabled> disabled</#if><#if readonly> readonly</#if><#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if><#if pattern!=''>pattern=${pattern}</#if><#if min!=0> min="${min}"</#if><#if max!=0> max="${max}"</#if><#if mandatory?? && mandatory> required</#if><#if labelFor?? && labelFor!='' && helpKey?? && helpKey!=''> aria-describedby="${labelFor}_help"</#if> />
<#elseif type='hidden'>
	<input type="hidden" name="${name}" value="${value}" />
<#else><@icon style='warning' />Type not supported
</#if>
<#if type != 'hidden'>
</div>
</#if>
</#macro>

<#-- STATIC TEXT -->
<#-- Bootstrap colors: muted/primary/success/info/warning/danger -->
<#-- AdminLTE colors: red/yellow/aqua/blue/black/light-blue/green/gray/navy/teal/olive/lime/orange/fuchsia/purple/maroon -->
<#macro staticText inForm=true color='' id='' params=''>
<p class="<#if inForm>field-static</#if><#if color!=''> text-${color}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</p>
</#macro>

<#-- CHECKBOX -->
<#-- orientation: vertical/horizontal. Default is vertical -->
<#macro checkBox name id labelKey='' labelFor='' orientation='vertical' value='' tabIndex='' title='' disabled=false readonly=false checked=false params='' mandatory=false>
<#if labelFor = ''><#local labelFor = id /></#if>
<#if orientation='vertical'><div class="checkbox"></#if>
	<label<#if orientation='horizontal'> class="checkbox-inline"</#if><#if labelFor!=''> for="${labelFor}"</#if>>
	<input type="checkbox" id="${id}" name="${name}"<#if value!=''> value="${value}"</#if><#if tabIndex!=''> tabindex="${tabIndex}"</#if><#if checked> checked</#if><#if disabled> disabled</#if><#if readonly> readonly</#if><#if params!=''> ${params}</#if><#if mandatory> required</#if> />
	<#if labelKey!=''>${labelKey}</#if>
	</label>
<#if orientation='vertical'></div></#if>
</#macro>

<#-- RADIO BUTTON -->
<#-- orientation: vertical/horizontal. Default is vertical -->
<#macro radioButton name id='' value='' labelKey='' labelFor='' orientation='vertical' tabIndex='' title='' disabled=false readonly=false checked=false params=''>
<#if orientation='vertical'><div class="radio"></#if>
	<label<#if orientation='horizontal'> class="radio-inline"</#if>>
	<input type="radio" id="${id}" name="${name}"<#if value!=''> value="${value}"</#if><#if tabIndex!=''> tabindex="${tabIndex}"</#if><#if checked> checked</#if><#if disabled> disabled</#if><#if readonly> readonly</#if><#if mandatory?? && mandatory> required</#if><#if params!=''> ${params}</#if> />
	<#if labelKey!=''>${labelKey}</#if>
	</label>
<#if orientation='vertical'></div></#if>
</#macro>


<#-- INPUT-GROUP -->
<#-- size: ignored -->
<#macro inputGroup size='' id='' params=''>
<div class="field has-addons" <#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#macro inputGroupItem pos='' type='btn' id='' params=''>
<#-- type: btn/text. default is btn-->
<div class="control"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<div class="button<#if type='text'> is-static</#if>">
	<#nested>
	</div>
</div>
</#macro>

<#-- ROW -->
<#macro row class='' id='' params=''>
<div class="columns is-multiline<#if class!=''> ${class}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#-- COLUMNS -->
<#-- cols -->
<#macro columns offsetXs=0 offsetSm=0 offsetMd=0 offsetLg=0 offsetXl=0 pushXs=0 pushSm=0 pushMd=0 pushLg=0 pushXl=0 pullXs=0 pullSm=0 pullMd=0 pullLg=0 pullXl=0 xs=12 sm=0 md=0 lg=0 xl=0 id='' class='' params=''>
<div class="column<#if class!=''> ${class}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
<#nested>
</div>
</#macro>

<#-- LISTS -->
<#macro ul id='' params='' class=''>
	<ul<#if class!=''> class="${class}"</#if><#if params!=''> ${params}</#if><#if id!=''> ${id}</#if>>
		<#nested>
	</ul>
</#macro>

<#macro li id='' params='' class=''>
		<li<#if class!=''> class="${class}"</#if><#if params!=''> ${params}</#if><#if id!=''> ${id}</#if>>
			<#nested>
		</li>
</#macro>

<#-- PARAGRAPH -->
<#macro p id='' params='' class='' hide=[] align=''>
	<#local class += alignmentSettings(align) />
	<#local class += displaySettings(hide,'is-block') />
	<p<#if class!=''> class="${class}"</#if><#if params!=''> ${params}</#if><#if id!=''> ${id}</#if>>
		<#nested>
	</p>
</#macro>

<#-- SPAN -->
<#macro span id='' params='' class='' hide=[] align=''>
	<#local class += alignmentSettings(align) />
	<#local class += displaySettings(hide,'is-inline') />
	<span<#if class!=''> class="${class}"</#if><#if params!=''> ${params}</#if><#if id!=''> ${id}</#if>>
		<#nested>
	</span>
</#macro>

<#-- PRE -->
<#macro pre id='' params='' class='' hide=[] align=''>
	<#local class += alignmentSettings(align) />
	<#local class += displaySettings(hide,'is-block') />
	<pre<#if class!=''> class="${class}"</#if><#if params!=''> ${params}</#if><#if id!=''> ${id}</#if>>
		<#nested>
	</pre>
</#macro>

<#-- TABS -->

<#-- TAB -->
<#macro tabs color='' id='' params=''>
	<#nested>
</#macro>

<#-- Tabs List -->
<#-- type:  -->
<#macro tabList type='tabs' vertical=false id='' params='' color=''>
<div class="tabs is-boxed is-fullwidth<#if color!=''> ${color}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<ul<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
		<#nested>
	</ul>
</div>
</#macro>

<#-- Tabs -->
<#-- type:  -->
<#macro tabLink class='' hide=[] id='' active=false href='' title='' tabIcon='' params=''>
		<li class="<#if class!=''>${class}</#if><#if active> is-active</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
			<@link href='${href}' title='${title}'>
				<#if tabIcon!=''><span class="icon is-small"><@icon style=tabIcon /></span></#if>
				${title}
			</@link>
		</li>
</#macro>

<#-- TAB Content -->
<#macro tabContent id='' params=''>
<div class="is-clearfix"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#-- Tab Panel BS4 -->
<#macro tabPanel id params='' active=false>
		<div class="tab-pane fade<#if active> show active</#if>" role="tabpanel" id="${id}" aria-labelledby="${id}-tab"<#if params!=''> ${params}</#if>>
			<#nested>
		</div>
</#macro>

<#-- ACCORDION --> 
<#-- The accordionContainer is the container for accordionPanel, which itself is the container for accordionHeader and accordionBody -->
<#-- The childId argument in accordionPanel is meant to be used in the two sub-macros: accordionHeader and accordionBody -->
<#macro accordionContainer id='' params=''>
<div class="accordions" <#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#assign parentId = id>
	<#nested>
</div>
<script type='text/javascript'>
    var accordions = bulmaAccordion.attach();     
</script>
    
</#macro>

<#macro accordionPanel color='' collapsed=true childId='' id='' params=''>
<div class="accordion"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#if collapsed = true>
		<#assign aClass = ''>
		<#assign expanded = 'false'>
		<#assign childClass = 'panel-collapse collapse'>
	<#else>
		<#assign aClass = 'is-active'>
		<#assign expanded = 'true'>
		<#assign childClass = 'panel-collapse collapse in'>
	</#if>
		<#assign childId = childId>
	<#nested>
</div>
</#macro>

<#-- ACCORDION ELEMENT --> 
<#-- The boxTools parameter is unused, kept for backwards compatibility -->
<#macro accordionHeader title='' parentId=parentId childId=childId boxTools=false id='' params='' headerIcon='' >
<div class="accordion-header toggle has-background-light"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<h2 class="title has-text-primary">
        <#if headerIcon!=''><@icon style=headerIcon /></#if> &nbsp;
        ${title}
    </h2>
	<#local nested><#nested></#local>
	<#if nested?has_content>
	<div class="is-pulled-right">
		${nested}
	</div>
	</#if>
</div>
</#macro>

<#macro accordionBody id=childId class=childClass expanded=expanded params=''>
<div id="${id}" class="accordion-body ${class}" aria-expanded="${expanded}"<#if params!=''> ${params}</#if>>
	<@boxBody>
		<#nested>
	</@boxBody>
</div>
</#macro>



<#macro progressBar description='' id='' params=''>
<div class="progress"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<div id="progressbar" class="progress-bar progress-bar-striped" role="progressbar">
		<div id="complexity">0%</div>
	</div>
</div>
<#if description!=''>
<span class="progress-description">${description}</span>
</#if>
</#macro>


<#macro progress  color='primary' id='' params='' value=0 min=0 max=100 text=''>
    <progress class="progress is-${color}" value="${value}" max="${max}"><#if text=''>${value}%<#else>${text}</#if></progress>
</#macro>


<#-- TAG -->
<#-- color: default/primary/success/info/warning/danger/ -->
<#macro tag color='default'  size='' title='' tagIcon='' id='' params=''>
    <#switch size>
        <#case 'xs'>
            <#assign tagSize='is-small'>
            <#break>
        <#case 'sm'>
            <#assign tagSize=''>
            <#break>
        <#case 'md'>
            <#assign tagSize='is-medium'>
            <#break>
        <#case 'lg'>
            <#assign tagSize='is-large'>
            <#break>
        <#default>
            <#assign tagSize='is-normal'>
    </#switch>

	<span class="tag is-${color} <#if tagSize!=''>${tagSize}</#if>"<#if title!=''> title='${title}'</#if><#if id!=''>id='${id}'</#if><#if params!=''>${params}</#if>>
        <#if tagIcon !=''>
            <@icon style=tagIcon /> &nbsp;
        </#if>
		<#nested>
	</span>
</#macro>

<#-- BUTTON -->
<#-- size: xs/sm/md/lg -->
<#-- color: default : primary/success/warning/danger/info -->
<#-- type: button/submit/reset -->
<#-- params: data-toggle/data-target/data-dismiss... -->
<#-- buttonIcon: icon name ex: info/check/comment/envelope... -->
<#-- iconPosition: left/right -->
<#-- cancel: switch to true for a cancellation form button. Adds the "formnovalidate" attribute to the button, as well as the right class -->
<#-- form: contains the form ID if the button is outside of the form -->
<#macro button name='' id='' type='button'  buttonIcon='' size='' color='' style='' class='' params='' value='' title='' tabIndex='' hideTitle=[] showTitle=true showTitleXs=true showTitleSm=true showTitleMd=true showTitleLg=true disabled=false iconPosition='left' dropdownMenu=false cancel=false form=''>

<#local displayTitleClass = displaySettings(hideTitle,'inline') />

	<#if cancel || color = 'default' || color = 'secondary'>
		<#assign buttonColor = 'light' />
	<#elseif !cancel && color=''>
		<#assign buttonColor = 'primary' />
	<#else>
		<#assign buttonColor = color />
	</#if>
	<#if style='card-control'>
		<#assign style='text-right btn-link' />
	</#if>

<#switch size>
    <#case 'xs'>
        <#assign buttonSize='small'>
        <#break>
    <#case 'sm'>
        <#assign buttonSize='small'>
        <#break>
    <#case 'md'>
        <#assign buttonSize='medium'>
        <#break>
    <#case 'lg'>
        <#assign buttonSize='large'>
        <#break>
    <#default>
        <#assign buttonSize='normal'>
</#switch>

<#if dropdownMenu>
<div class="dropdown">
	<div class="dropdown-trigger">
</#if>
	<button class="button<#if buttonSize!=''> is-${buttonSize}</#if><#if buttonColor!=''> is-${buttonColor}</#if><#if dropdownMenu> dropdown-toggle</#if><#if class!=''> ${class}</#if>" type="${type}"<#if title!=''> title="${title}"</#if><#if name!=''> name="${name}"</#if><#if id!=''> id="${id}"</#if><#if value!=''> value="${value}"</#if><#if params!=''> ${params}</#if><#if disabled> disabled</#if><#if dropdownMenu> aria-haspopup="true" aria-controls="<#if id!=''>${id}</#if>-content"</#if><#if cancel> formnovalidate</#if><#if form!=''> form="${form}"</#if>>
    <#if buttonIcon!='' && iconPosition='left'><@icon style=buttonIcon />&nbsp;</#if>
		<#if displayTitleClass!='' && style!='card-control'><span class="${displayTitleClass}"></#if>${title}<#if displayTitleClass!='' && style!='card-control'></span></#if>
		<#if buttonIcon!='' && iconPosition='right'>&nbsp;<@icon style=buttonIcon /></#if>
		<#if dropdownMenu>
		&nbsp;<@icon style='angle-down' />
		</#if>
	</button>
<#if dropdownMenu>
	</div>
	<div class="dropdown-menu"<#if id!=''> id="${id}-content" aria-labelledby="${id}"</#if> role="menu">
		<div class="dropdown-content">
			<#nested>
		</div>
	</div>
</div>
</#if>
</#macro>

<#-- A BUTTON (LINK STYLED AS A BUTTON) -->
<#-- size: small/medium/large -->
<#-- color: default/primary/success/warning/danger/info/bg-purple/bg-blue/bg-navy/bg-teal/bg-maroon/bg-black/bg-gray/bg-olive/bg-lime/bg-orange/bg-fuchsia -->
<#-- style: disabled ignored : btn-block/btn-flat/btn-app-->
<#-- icon: icon name ex: info/check/comment/envelope... -->
<#macro aButton name='' id='' href='' size='' color='primary' style='' class='' params='' title='' tabIndex='' hideTitle=[] showTitle=true showTitleXs=true showTitleSm=true showTitleMd=true showTitleLg=true buttonIcon='' disabled=false iconPosition='left' dropdownMenu=false cancel=false>
<#local displayTitleClass = displaySettings(hideTitle,'inline') />
	<#if cancel || color = 'default' || color = 'secondary'>
		<#assign buttonColor = 'light' />
	<#elseif !cancel && color=''>
		<#assign buttonColor = 'primary' />
	<#else>
		<#assign buttonColor = color />
	</#if>
	<#if style='card-control'>
		<#assign style='text-right btn-link' />
	</#if>

<#switch size>
    <#case 'xs'>
        <#assign buttonSize='small'>
        <#break>
    <#case 'sm'>
        <#assign buttonSize='small'>
        <#break>
    <#case 'md'>
        <#assign buttonSize='medium'>
        <#break>
    <#case 'lg'>
        <#assign buttonSize='large'>
        <#break>
    <#default>
        <#assign buttonSize='normal'>
</#switch>

<#if dropdownMenu>
<div class="dropdown">
	<div class="dropdown-trigger">
</#if>

<a class="button is-grouped <#if buttonSize!=''>is-${buttonSize}</#if><#if buttonColor!=''> is-${buttonColor}</#if><#if style!=''> ${style}</#if><#if class!=''> ${class}</#if>"<#if name!=''> name="${name}"</#if><#if id!=''> id="${id}"</#if> href="${href}" title="${title}"<#if params!=''> ${params}</#if><#if disabled> disabled</#if><#if dropdownMenu> data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"</#if>>
   <#if buttonIcon!='' && iconPosition='left'><@icon style=buttonIcon /> &nbsp; </#if>
	<span class="${displayTitleClass}">${title}</span>
	<#if buttonIcon!='' && iconPosition='right'> &nbsp; <@icon style=buttonIcon /></#if>
	<#if dropdownMenu>&#160;<@icon style='caret-down' /></#if>
	<#if !dropdownMenu>
		<#nested>
	</#if>
</a>
	<#if dropdownMenu>
	</div>
	<div class="dropdown-menu"<#if id!=''> id="${id}-content" aria-labelledby="${id}-content"</#if> role="menu">
		<div class="dropdown-content">
			<#nested>
		</div>
	</div>
</div>
	</#if>
</#macro>

<#macro dropdownItem>
			<li><#nested></li>
</#macro>

<#-- BTN TOOLBAR -->
<#macro btnToolbar id='' params='' ariaLabel=''>
<div class="field is-grouped" role="toolbar"<#if ariaLabel!=''> aria-label="${ariaLabel}"</#if><#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#-- BTN GROUP -->
<#-- size: sm/lg -->
<#-- align: left/center/right -->
<#macro btnGroup size='' align='' class='' id='' params='' ariaLabel='' hide=[] showXs=true showSm=true showMd=true showLg=true showXl=true>
<#local displayClass = displaySettings(hide,'inline-flex') />
    <#switch size>
        <#case 'sm'>
            <#assign sizeClass='are-small'>
            <#break>
        <#case 'lg'>
            <#assign sizeClass='are-large'>
            <#break>
            <#default>
        <#assign sizeClass=''>
    </#switch>

    <#switch align>
        <#case 'right'>
            <#assign alignClass='is-right'>
            <#break>
        <#case 'center'>
            <#assign alignClass='is-centered'>
            <#break>
        <#default>
        <#assign alignClass=''>
    </#switch>
    
    <div class="buttons ${alignClass} ${sizeClass} <#if class!=''>${class}</#if><#if displayClass !=''> ${displayClass}</#if>" role="group"<#if ariaLabel!=''> aria-label="${ariaLabel}"</#if><#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
        <#nested>
    </div>
</#macro>



<#-- Radio button/Checkbox as buttons (to use with btnGroup)  -->
<#-- type: radio/checkbox -->
<#macro btnGroupRadioCheckbox type='checkbox' color='primary' size='' name='' id='' params='' ariaLabel='' labelFor='' labelKey='' labelParams='' tabIndex='' value='' checked=false>
<label class="button is-${color}<#if size!=''> btn-${size}</#if>" for="${labelFor}"<#if labelParams!=''> ${labelParams}</#if>>
	<input type="${type}" name="${name}" id="${id}" autocomplete="off"<#if value!=''> value="${value}"</#if><#if params!=''> ${params}</#if><#if tabIndex!=''> tabindex="${tabIndex}"</#if><#if checked> checked</#if> /><#if labelKey!=''>${labelKey}</#if>
</label>
</#macro>


<#-- Simple links a href, anchors -->
<#macro link href='' class='' id='' name='' title='' alt='' target='' params=''>
	<a href="${href}"<#if class!=''> class="${class}"</#if><#if id!=''> id="${id}"</#if><#if name!=''> name="${name}"</#if><#if target!=''> target="${target}"</#if><#if title!=''> title="${title}"</#if><#if alt!=''> alt="${alt}"</#if><#if params!=''> ${params}</#if>>
		<#nested>
	</a>
</#macro>


<#-- MODAL -->
<#-- bgColor: modal-default/modal-primary/modal-info/modal-warning/modal-danger -->
<#macro modal id params='' bgColor=''>
<div class="modal ${bgColor} fade" tabindex="-1" role="dialog" id="${id}" data-toggle="modal"<#if params!=''> ${params}</#if>>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<#nested>
		</div>
	</div>
</div>
</#macro>

<#macro modalHeader titleLevel='h4' modalTitle='' id='' params=''>
<div class="modal-header"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<button type="button" class="delete" data-dismiss="modal" aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
	<${titleLevel} class="modal-title">${modalTitle}</${titleLevel}>
</div>
</#macro>

<#macro modalBody id='' params=''>
<div class="modal-body"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#macro modalFooter id='' params=''>
<div class="modal-footer"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#-- BREADCRUMBS -->
<#macro breadcrumbs id='' params=''>
<ol class="breadcrumb"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</ol>
</#macro>

<#-- CALLOUT -->
<#-- AdminLTE classes: info/warning/danger/success -->
<#macro callOut color='' titleLevel='h3' title='' callOutIcon='' id='' params=''>
<div class="callout callout-${color}"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#if title!=''><${titleLevel}><@icon style=callOutIcon /> ${title}</${titleLevel}></#if>
	<#nested>
</div>
</#macro>

<#-- ALERT -->
<#-- class:  -->
<#-- color: success/info/warning/danger -->
<#macro alert class='' color='' titleLevel='h3' title='' iconTitle='' dismissible=false id='' params=''>
<div class="notification ${class} <#if color!=''> is-${color}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
<#if dismissible>
	<@button color='' size='' class='delete' params='data-dismiss="alert" aria-hidden="true"'>&times;</@button>
</#if>
<#if title!=''>
<${titleLevel}>
	<#if iconTitle!=''><@icon style=iconTitle /></#if>
	${title}
</${titleLevel}>
</#if>
<#nested>
</div>
</#macro>


<#---------------------------------------->
<#-- AdminLTE Box -->
<#-- color: default/primary/info/success/warning/danger -->
<#-- style: solid (no top border) -->
<#-- collapsed: true/false -->
<#macro box color='' id='' style='' class='' params='' collapsed=false>
<div class="card<#if color!=''> has-${color}</#if><#if style!=''> box-${style}</#if><#if class!=''> ${class}</#if><#if collapsed> collapsed-box</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#-- The boxTools parameter is unused, kept for backwards compatibility -->
<#macro boxHeader title='' i18nTitleKey='' hideTitle=[] showTitle=true id='' params='' boxTools=false titleLevel='p'>
<header class="card-header"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
<${titleLevel} class="card-header-title<#if showTitle=false> sr-only</#if>"><#if title!=''>${title}</#if><#if i18nTitleKey!=''>#i18n{${i18nTitleKey}}</#if></${titleLevel}>
	<#nested>
</header>
</#macro>

<#macro boxBody class='' id='' params=''>
<div class="card-content<#if class!=''> ${class}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#macro boxFooter class='' id='' params=''>
<div class="card-footer"<#if class!=''> ${class}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#---------------------------------------->
	
<#-- INFO-BOX AdminTLE (widget) -->
<#-- color: only for the left side showing the icon. -->
<#-- bgColor: for the right side containing the text -->
<#macro infoBox color='' boxText='' boxIcon='' boxNumber='' unit='' bgColor='' progressBar='' progressDescription='' id='' params=''>
	<div class="box<#if bgColor!=''> ${bgColor}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
		<span class="info-box-icon<#if color!=''> ${color}</#if>"><@icon style=boxIcon /></span>
		<div class="info-box-content">
			<span class="info-box-text">${boxText}</span>
			<span class="info-box-number">${boxNumber?string(",000")}<#if unit!=''> <small>${unit}</small></#if></span>
			<#if bgColor!='' && progressBar!=''>
				<progress class="progress is-primary" value="${progressBar}" max="100"> ${progressBar}%</progress>
			</#if>
			<#if progressDescription!=''>
			<p>${progressDescription}</p>
			</#if>
		</div>
	</div>
</#macro>	

<#-- AdminLTE Small Box -->
<#-- color: Bootstrap + AdminLTE colors -->
<#-- unit: %,... -->
<#macro smallBox color='' title='' text='' boxIcon='' titleLevel='h3' unit='' url='' urlText='' id='' params='' fontSize='30px'>
<div class="box<#if color!=''> has-background-${color}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<article class="media">
		<div class="media-left">
			<figure class="image is-64x64">
				<@icon style=boxIcon class="fa-3x" />
			</figure>
		</div>
		<div class="media-content">
		<div class="content">	
            <p>${text}</p>
            <${titleLevel} style="font-size:${fontSize};">${title}<#if unit!=''> &nbsp; ${unit}</#if></${titleLevel}>
		</div>
		<#if url!=''>
		<a class="small-box-footer" href="${url}">${urlText} <@icon style='arrow-circle-right' /></a>
		</#if>
	</article>
</div>
</#macro>

<#-- AdminLTE Error Page -->
<#-- Error Type: 500,404... -->
<#-- Color: primary/blue/navy/aqua/teal/green/orange/yellow/red/purple/maroon/gray/black... -->
<#macro errorPage color='' errorType='' id='' params=''>
<div class="error-page"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<h2 class="headline text-${color}">${errorType}</h2>
	<div class="error-content">
		<h3>
			<@icon style='warning' class='text-${color}' />
			<#if errorType=='404'>
				#i18n{portal.util.error404.title}
			<#elseif errorType='500'>
				#i18n{portal.util.error500.title}
			<#else>...
			</#if>
		</h3>
		<p>
			<#if errorType=='404'>
				#i18n{portal.util.error404.text} 
			<#elseif errorType='500'>
				#i18n{portal.util.error500.text} 
			<#else>...
			</#if>
		</p>
		<@aButton href='' size='' color='bg-${color}' style=''>
			<@icon style='home' />
			#i18n{portal.util.labelBackHome}
		</@aButton>
	</div>
</div>
</#macro>

<#-- CONTEXTUAL BACKGROUND P-->
<#-- Bootstrap colors: primary/success/info/warning/danger -->
<#-- AdminTLE colors: gray/gray-light/black/red/yellow/aqua/blue/light-blue/green/navy/teal/olive/lime/orange/fuchsia/purple/maroon -->
<#macro coloredBg color='' type='p' id='' params=''>
<${type} class="bg-${color}"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</${type}>
</#macro>

<#macro listGroup id='' params=''>
<div class="panel"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#macro listGroupItem id='' params=''>
<div class="panel-block"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#macro unstyledList id='' params=''>
<ul class="unstyled"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#assign liClass = "margin">
	<#nested>
</ul>
</#macro>

<#-- DROPDOWN MENU LIST -->
<#macro dropdownList id='' params=''>
<div class="dropdown is-active">
	<div class="dropdown-trigger">
		<button class="button is-primary is-sm" aria-haspopup="true" aria-controls="dropdown-menu">
		<span>Dropdown button</span>
		<span class="icon is-small">
			<i class="fa fa-angle-down" aria-hidden="true"></i>
		</span>
		</button>
	</div>
	<div class="dropdown-menu" id="dropdown-menu" role="menu">
		<div class="dropdown-content">
			<#nested>
		</div>
	</div>
</#macro>

<#macro dropdownItem class='' href='' title='' id='' params=''>
		<a href="${href}" class="dropdown-item<#if class!=''> ${class}</#if>" title="${title}"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>${title}</a>
</#macro>

<#-- CARDS -->
<#macro card header=false headerTitle='' headerIcon=false headerTitleIcon=''>
<div class="panel panel-default">
	<#if header><div class="panel-heading"><#if headerIcon><@icon style='${headerTitleIcon}' />&#160;</#if>${headerTitle}</div></#if>
	<div class="panel-body">
		<#nested>
	</div>
</div>
</#macro>


<#-- FUNCTION: DISPLAY -->
<#-- This function returns a "visible" or "hidden" class for any component -->
<#-- breakpoints: "all" || "xs"/"sm"/"md"/"lg"/"xl" -->
<#-- display: is-block/is-flex/is-inline/is-inline-block/is-inline-flex -->
<#function displaySettings breakPoints=[] display=''>
	<#local breakPointsOrdered = [] />
	<#if breakPoints?seq_contains('all')>
		<#local breakPointsOrdered += ['all'] />
	</#if>
	<#if breakPoints?seq_contains('xs')>
		<#local breakPointsOrdered += ['xs'] />
	</#if>
	<#if breakPoints?seq_contains('sm')>
		<#local breakPointsOrdered += ['sm'] />
	</#if>
	<#if breakPoints?seq_contains('md')>
		<#local breakPointsOrdered += ['md'] />
	</#if>
	<#if breakPoints?seq_contains('lg')>
		<#local breakPointsOrdered += ['lg'] />
	</#if>
	<#if breakPoints?seq_contains('xl')>
		<#local breakPointsOrdered += ['xl'] />
	</#if>

	<#local displayClass = '' />
	<#if breakPointsOrdered?? && breakPointsOrdered?size &gt; 0>
		<#list breakPointsOrdered as breakPoint>
			<#if breakPoint = 'all'>
				<#local displayClass = 'is-hidden' />
			<#elseif breakPoint = 'xs'>
				<#local displayClass = displayClass + ' is-hidden-mobile' />
			<#elseif breakPoint = 'sm'>
				<#local displayClass = displayClass + ' is-hidden-tablet-only' />
			<#elseif breakPoint = 'md'>
				<#local displayClass = displayClass + ' is-hidden-desktop-only' />
			<#elseif breakPoint = 'lg'>
				<#local displayClass = displayClass + ' is-hidden-widescreen-only' />
			<#elseif breakPoint = 'xl'>
				<#local displayClass = displayClass + ' is-hidden-fullhd' />
			<#else>
				<#local displayClass = displayClass + ' undefined_breakpoint' />
			</#if>
		</#list>
	</#if>
	<#return displayClass?trim>
</#function>

<#function alignmentSettings align=''>
	<#local x = ''>
	<#if align !=''>
		<#if align = 'left'>
			<#local x = 'is-left' />
		<#elseif align = 'right'>
			<#local x = 'is-right' />
		<#elseif align = 'center'>
			<#local x = 'is-centered' />
		</#if>
	</#if>
	<#return x>
</#function>


<#-- NEW MACRO LUTECE-2221 -->

<#-- UI STRUCTURE ELEMENTS -->
<#-- MACRO adminHeader -->
<#macro adminHeader site_name=site_name>
<body class="has-navbar-fixed-top">
	<div class="wrapper">
		<header class="main-header" role="banner">
			<nav class="navbar is-fixed-top" role="navigation">
				<div class="navbar-brand">
					<a href="jsp/site/Portal.jsp" title="#i18n{portal.users.admin_header.title.viewSite} ${site_name}" target="_blank" class="navbar-item">
						<img src="#dskey{portal.site.site_property.logo_url}" class=""  title="#i18n{portal.users.admin_header.title.viewSite} ${site_name}" alt="${site_name}"><b> <#if site_name?length &gt; 18> ${site_name?substring(0,16)}... <#else> ${site_name}</#if></b>
					</a>
					<a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false">
						<span aria-hidden="true"></span>
						<span aria-hidden="true"></span>
						<span aria-hidden="true"></span>
					</a>
				</div>
				<div class="navbar-menu"  id="navbar-collapse">
					<div class="navbar-start">
						<#list feature_group_list as feature_group>
						   <#if feature_group.features?size &gt; 1>
						  	 <div class="navbar-item has-dropdown is-hoverable">
							   		<a class="navbar-link" id="dLabel${feature_group.id}Header">
								   		${feature_group.label}
									</a>
									<div class="navbar-dropdown" role="menu" aria-labelledby="dLabel${feature_group.id}Header">
								 	<#list feature_group.features as feature>
								   		<#if !feature.externalFeature>
											<a class="navbar-item" href="${feature.url}?plugin_name=${feature.pluginName}">${feature.name}</a>
									 	<#else>
											<a class="navbar-item" href="${feature.url}"><#if feature.iconUrl?has_content><i class="${feature.iconUrl}"></i></#if> ${feature.name}</a>
								  		</#if>
								 	</#list>
									</div>
								</div>
						   <#else>
							 	<#list feature_group.features as feature>
							  		<#if !feature.externalFeature>
										<a class="navbar-item" href="${feature.url}?plugin_name=${feature.pluginName}">${feature.name}</a>
								  	<#else>
										<a class="navbar-item" href="${feature.url}"><#if feature.iconUrl?has_content><i class="${feature.iconUrl}"></i></#if>${feature.name}</a>
								  	</#if>
							 	</#list>
							</#if>
					   </#list>
					</div>
				    <div class="navbar-end user">
						<div class="navbar-item">
                            <a class="button is-primary" href="${admin_url}" title="#i18n{portal.users.admin_header.homePage}">
                                  <i class="fa fa-home"></i>
                            </a>
						</div>
                        <#if user.userLevel == 0>
						<div class="navbar-item">
                            <a class="button is-danger" href="jsp/admin/AdminTechnicalMenu.jsp" title="#i18n{portal.admindashboard.view_dashboards.title}">
                                  <i class="fa fa-cog"></i>
                            </a>
						</div>
                        </#if>
						<div class="navbar-item has-dropdown is-hoverable">
							<a class="navbar-link">
								<#if adminAvatar> 
									<img src="servlet/plugins/adminavatar/avatar?id_user=${user.userId}" id="admin-avatar" class="user-image" alt="User's avatar"> 
								<#else> 
									<img src="#dskey{portal.site.site_property.avatar_default}" id="admin-avatar" class="user-image" alt="User's avatar"> 
								</#if>     
								<span id="zone4" class="hidden-sm hidden-md"> ${dashboard_zone_4}<i class="caret"></i></span>
						  	</a>
                            <#if userMenuItems?has_content>   
                              <ul class="navbar-dropdown" role="menu" aria-labelledby="dLabelUserHeader">
								<#list userMenuItems as item>
									${item.content}
								</#list>
                              </ul>
                            </#if>
                        </div>
						<#if admin_logout_url?has_content>
						<div class="navbar-item">
							<a class="button is-danger"  href="${admin_logout_url}" title="#i18n{portal.users.admin_header.deconnectionLink}">
								<i class="fa fa-power-off fa-fw"></i> 
							</a>
						</div>
						</#if>
						</div>
					</div>
				</div>
			</nav>
			</header>
			  <!-- Wrapper -->
			  <div id="admin-wrapper">
					<section class="content">
				  <!-- Close in footer -->
</#macro>


<#-- MACRO adminFooter -->
<#macro adminFooter >
		<!-- end content section -->
		</section>
	<!--  end admin-wrapper -->
	</div>
<!-- end wrapper -->
</div>
<!-- footer menu -->
<footer class="footer">
	<div class="content has-text-centered">
		<p>
			<a href="http://fr.lutece.paris.fr" target="lutece" title="#i18n{portal.site.portal_footer.labelPortal}">
				<img src="images/poweredby.png" alt="#i18n{portal.site.portal_footer.labelMadeBy}">
				<small>version ${version}</small>
			</a>
		</p>
	</div>
</footer>
<!-- Included JS Files -->
<!-- Le javascript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<@coreAdminJSLinks />
<script>
$( function() {
	// Check for click events on the navbar burger icon
	$(".navbar-burger").click(function() {
		// Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
		$(".navbar-burger").toggleClass("is-active");
		$(".navbar-menu").toggleClass("is-active");
	});
});
</script>
</#macro>

<#-- MACRO adminHome -->
<#macro adminHome >
<@row>
	<@columns class='widget'>
		<section class="dashboard-widgets">
			<@row>
				<@columns sm=4 md=4 lg=4 class='widget lutece-dashboard'>
					<#if dashboard_zone_1?has_content>
						${dashboard_zone_1}
					</#if>
					<div>&nbsp;</div>
				</@columns>
				<@columns sm=4 md=4 lg=4 class='widget lutece-dashboard'>
					<#if dashboard_zone_2?has_content>
						${dashboard_zone_2}
					</#if>
					<div>&nbsp;</div>
				</@columns>
				<@columns sm=4 md=4 lg=4 class='widget lutece-dashboard'>
					<#if dashboard_zone_3?has_content>
						${dashboard_zone_3}
					</#if>
					<div>&nbsp;</div>
				</@columns>
			</@row>
		</section>
	</@columns>
</@row>
</#macro>

<#-- adminContentHeader  -->
<#macro adminContentHeader >
<section class="content-header">
	<h1>
        <#if feature_url?? && feature_title?? >
    		<a href="${feature_url}" title="${feature_title!''}">${feature_title!''}</a>
        <#else>
            ${feature_title!''}
        </#if>
		<#if page_title?? && page_title?has_content><span class="is-size-4 has-text-grey-light">${page_title}</span></#if>
	</h1>
	<@adminHeaderDocumentationLink />
</section>
<section class="content <#if feature_url?? && feature_url?ends_with('AdminSite.jsp')>no-padding</#if>">
</#macro>

<#-- adminLoginPage  -->
<#macro adminLoginPage title='' site_name='SITE_NAME'>

<div class=container" id="login-page">
    <img src="images/logo-header.png" id="logoLogin" title="LUTECE Back-Office" alt="LUTECE Back-Office">
    <div class="columns">
        <div class="column is-4 is-offset-4">
            <div class="card" >
                <div class="card-header">
                    <div class="card-header-title has-background-primary has-text-centered">
                      <a href="jsp/site/Portal.jsp" title="${site_name}">#i18n{portal.admin.admin_login.welcome}<br> <b>${site_name}</b></a>
                    </div>
                </div>
                <div class="card-content">
                    <div class="login-box-header">
                        <p class="text-center">${title}</p>
                    </div>
                    <#nested>
                    <p class='has-text-centered'>
                        <@aButton href='http://fr.lutece.paris.fr' params='target="_blank"' title='#i18n{portal.site.portal_footer.labelPortal}' hideTitle=['all'] color='secondary'>
                            <img src="images/poweredby.png" class="thumbnails" alt="logo lutece" title="Lutece">
                        </@aButton>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
$(function() {
	var randomImages = [#dskey{portal.site.site_property.back_images}];
	var rndNum = Math.floor(Math.random()*(randomImages.length));
	var bgImg = 'url(' + randomImages[rndNum] + ')';
	$("#login-page").css('background-image', bgImg );
});
</script>
</#macro>


<#-- adminHeaderDocumentationLink  -->
<#macro adminHeaderDocumentationLink >
<ol class="breadcrumb ${feature_group!?lower_case} is-pulled-right">
  <#if feature_documentation?has_content >
	<#if feature_documentation?exists>
		<li>
			<a target="_blank" href="${feature_documentation}" title="#i18n{portal.features.documentation.help}">
				<i class="fa fa-life-ring" ></i> #i18n{portal.features.documentation.help}
			</a>
		</li>
	</#if>
</#if>
</ol>
</#macro>

<#macro adminSiteColumnOutline columnid=''>
<div class="admin_column_outline">
	<span class="admin_column_id">${i18n("portal.site.columnId",columnid)}</span>
	<div>
		<#nested>
	</div>
</div>
</#macro>

<#-- adminMessagePage  -->
<#macro adminMessagePage title=''>
<#assign color="info" />
<#assign icontype="fa-info-circle" />
<#if message.type == 2 >
   <#assign color="primary" />
   <#assign icontype="fa-question-circle" />
<#elseif message.type == 3 >
   <#assign color="danger" />
   <#assign icontype="fa-exclamation-circle" />
<#elseif message.type == 4 >
   <#assign color="danger" />
   <#assign icontype="fa-question-circle" />
<#elseif message.type == 5 >
   <#assign color="danger" />
   <#assign icontype="fa-ban" />
</#if>
<br>
<br>
<div class="columns">
    <div class="column is-4 is-offset-4">
        <div class="message" id="message-box">
            <div class="message-header has-background-${color}">
                <strong><span class="fa ${icontype}"></span> ${title!"Info"}</strong>
            </div>
            <div class="message-body has-background-grey-lighter">
                <p class="lead text-center">${text}</p>
                <div class="footer text-center  has-background-grey-lighter">
                    <#nested>
                </div>	
            </div>	
        </div>	
    </div>
</div>
</#macro>



<#-- HELPERS --> 

<#-- Float right  -->
<#macro fright> is-pulled-right</#macro>
<#-- Float left  -->
<#macro fright> is-pulled-left</#macro>
<#-- Clearfix  -->
<#macro fright> is-clearfix</#macro>

<#-- HTML ELEMENTS -->
<#macro img url='' alt='' title='' class='' id='' params=''> 
<img src="${url}" alt="<#if alt!=''>${alt!}<#else>${title!}</#if>" title="${title}" class="thumbnails thumb-list ${class}" id="${id}" ${params!} >
</#macro>

<#-- fieldSet  -->
<#macro fieldSet legend=''>
<fieldset class="box">
	<#if legend!=''>
		<legend class="label has-text-centered">${legend}</legend>
	</#if>
	<#nested>
</fieldset>
</#macro>


<#-- COMPONENTS --> 
<#--Badge : BS badge + label  -->
<#macro badge color='' badgeIcon='' title='' htmlEl='deprecated' type='deprecated' style='deprecated' class='deprecated' >
<span class="tag <#if color!=''>is-${color}</#if>" <#if title != ''> title="${title}" </#if> >
    <#if badgeIcon !=''>
        <@icon style=badgeIcon />
    </#if>
	<#nested>
</span>
</#macro>


<#-- Email Default Template -->
<#macro emailTemplate title='Lutece' footer_link='https://fr.lutece.paris.fr'> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width"/>
    <style type="text/css">
		* { margin: 0; padding: 0; font-size: 100%; font-family: 'Avenir Next', "Helvetica Neue", "Helvetica", Helvetica, Arial, sans-serif; line-height: 1.65; }
		img { max-width: 100%; margin: 0 auto; display: block; }
		body, .body-wrap { width: 100% !important; height: 100%; background: #f8f8f8; }
		a { color: #007bff; text-decoration: none; }
		a:hover { text-decoration: underline; }
		.text-center { text-align: center; }
		.text-right { text-align: right; }
		.text-left { text-align: left; }
		.button { display: inline-block; color: white; background: #007bff; border: solid #007bff; border-width: 10px 20px 8px; font-weight: bold; border-radius: 4px; }
		.button:hover { text-decoration: none; }
		h1, h2, h3, h4, h5, h6 { margin-bottom: 20px; line-height: 1.25; }
		h1 { font-size: 32px; }
		h2 { font-size: 28px; }
		h3 { font-size: 24px; }
		h4 { font-size: 20px; }
		h5 { font-size: 16px; }
		p, ul, ol { font-size: 16px; font-weight: normal; margin-bottom: 20px; }
		.container { display: block !important; clear: both !important; margin: 0 auto !important; max-width: 580px !important; }
		.container table { width: 100% !important; border-collapse: collapse; }
		.container .masthead { padding: 80px 0; background: #007bff; color: white; }
		.container .masthead h1 { margin: 0 auto !important; max-width: 90%; text-transform: uppercase; }
		.container .content { background: white; padding: 30px 35px; }
		.container .content.footer { background: none; }
		.container .content.footer p { margin-bottom: 0; color: #888; text-align: center; font-size: 14px; }
		.container .content.footer a { color: #888; text-decoration: none; font-weight: bold; }
		.container .content.footer a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<table class="body-wrap">
	<tr>
		<td class="container">
				<!-- Message start -->
				<table>
						<tr>
							<td align="center" class="masthead">
								<h1>${title}</h1>
							</td>
						</tr>
						<tr>
							<td class="content">
								<#nested>
							</td>
						</tr>
				</table>
		</td>
	</tr>
	<tr>
		<td class="container">
			<!-- Message start -->
			<table>
					<tr>
						<td class="content footer" align="center">
								<p><a href="${footer_link}">Lutece</a></p>
						</td>
					</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>		
</#macro>

<#macro adminLanguage languages lang action='jsp/admin/DoChangeLanguage.jsp' >
<a class="navbar-link" href="javascript:return false;">
	<i class="fa fa-language"></i> #i18n{portal.admin.admin_home.language}
</a>
<@tform method='post' action=action>
<input type="hidden" name="token" value="${token}">
<#list languages as language>
	<#if lang==language.code>
		<#assign languageButtonColor='success'>
	<#else>
		<#assign languageButtonColor='default'>
	</#if>
	<@button color='${languageButtonColor}' type='submit' name='language' value='${language.code}' title='${language.name}'/>
</#list>
</@tform>
</#macro>

<#macro adminAccessibilityMode>
<@tform method='post' action='jsp/admin/DoModifyAccessibilityMode.jsp' class=''>
	<input type="hidden" name="token" value="${token}">
	<#if user.accessibilityMode>
		<@button color='white' size='sm' type='submit' buttonIcon='eye' title='#i18n{portal.users.admin_header.labelDeactivateAccessibilityMode}'/>
	<#else>
		<@button color='white' size='sm' type='submit' buttonIcon='eye-slash' title='#i18n{portal.users.admin_header.labelActivateAccessibilityMode}'/>
	</#if>
</@tform>
</#macro>
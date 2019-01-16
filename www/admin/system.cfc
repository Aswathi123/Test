<cfcomponent output="false">
	
	<cffunction name="sendEmail" access="remote" output="false" returntype="boolean">
		
		<cfargument name="type" type="string" required="true" default="support">
		<cfargument name="to" type="string" default="salonworkssupport@salonworks.com">
		<cfargument name="from" type="string">
		<cfargument name="subject" type="string">
		
		<cfargument name="name" type="string">
		<cfargument name="message" type="string">
		<cftry>
			<cfset var obj = this />
			<cfset funcName = "#arguments.type#_mailBody">
			<cfset obj.$fn = obj[funcName]>
			<cfset var mailBody = obj.$fn(argumentCollection = arguments)>
			
			<cfmail from="salonworks@salonworks.com" to="ciredrofdarb@gmail.com" subject="#arguments.subject#" server="smtp-relay.sendinblue.com" port="587" type="HTML" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv" >
			#mailBody#
			</cfmail>
			<cfreturn true />
		<cfcatch>
			<cfreturn false />
		</cfcatch>
		</cftry>
		
	</cffunction>
	
	<cffunction name="support_mailBody" output="true">
		
		<cfsavecontent variable="mailBody">
		From: #arguments.Name#
				
		#arguments.Message#
		</cfsavecontent>
		
		#mailBody#
		
	</cffunction>
	
	<cffunction name="rowToStruct" access="public" returntype="struct" output="false">
		<cfargument name="queryObj" type="query" required="true" />
		<cfargument name="row" type="numeric" required="true" />
		    
		<cfset var returnStruct = structNew()>
		<cfset var colname = "">
		          
		<cfloop list="#arguments.queryObj.columnList#" index="colname">
		    <cfset returnStruct['#lcase(colname)#'] = arguments.queryObj[colname][arguments.row]>
		</cfloop>
		          
		<cfreturn returnStruct/>
	</cffunction>

	<cffunction name="rowToStructArray" access="public" returntype="array" output="false">
		<cfargument name="queryObj" type="query" required="true" />

		<cfset var returnArray = arrayNew(1) />

		<cfloop query="arguments.queryObj">
			<cfset var rowStruct = structNew() />
			<cfset var colname = '' />
			<cfloop list="#arguments.queryObj.columnList#" index="colname">
				<cfset rowStruct['#lcase(colname)#'] = arguments.queryObj[colname][arguments.queryObj.currentRow] />
			</cfloop>
			<cfset arrayAppend(returnArray, rowStruct) />
		</cfloop>

		<cfreturn returnArray />
	</cffunction>
	
</cfcomponent>
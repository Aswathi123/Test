<cfoutput>
	<table class="table table-bordered table-hover">
		<thead>
		</thead>
		<tbody>
			<cfloop from="1" to="7" index="d">							
				<tr>
					<td>#DayofWeekAsString(d)#</td>
					<td>#Evaluate('qLocation.#DayofWeekAsString(d)#_Hours')#</td>
				</tr>
			</cfloop>
		<tbody>
	</table>
</cfoutput>
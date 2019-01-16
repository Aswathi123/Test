<cfparam name="templatePath" type="string" default="/templates/#NumberFormat(application.template_id,'0000')#/">
<!--- <cfparam name="templatePath" type="string" default="/templates/0001/"> --->
<cfoutput>
	<cfinclude template="/customer_sites/customer_header.cfm">
	<cfinclude template="#templatePath#template_header.cfm">
	<!---<script type="text/javascript" src="js/imagelightbox.min.js"></script>--->
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/imagelightbox@0.10.0/src/imagelightbox.min.js"></script>
	<script>
		$( function() {
			$( '.popImage_img' ).imageLightbox({ 
				preloadNext:false 
			});
			$('.sdfkjdfh').click(function (evt) {
				evt.stopPropagation();
				// Your code here
			});
		});
		function disbaleClick(){
			$('##imagelightbox').click(function (evt) {
				evt.stopPropagation();
				// Your code here
			});
		}
		function popUp(id,ele){
			var image = $(ele).find('.image img').attr("src");
			//$('.galleryPopup .image img').attr("src",image);
		}
	</script>
	<div class="col-md-12" id="page-content">
		<div class="block-header">
			<h2>
				<span class="title">Gallery</span>
			</h2>
		</div>
		<cfquery name="getGallery" datasource="#request.dsn#">
			SELECT Gallery_ID,Company_ID,Professional_ID,Image_Name,Thumb_Name,Description 
			FROM Gallery WHERE Company_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.company_id#" > ORDER BY Gallery_ID DESC
		</cfquery>
		<div class="galleryPortFolio">
			<cfif getGallery.recordcount>
				<cfloop query="getGallery">
					<div class="eachPhotoWrap" onclick="popUp(#getGallery.Gallery_ID#,this)">
						<div class="image">	
							<!---<a href="admin\images\company\gallery\#getGallery.Company_ID#\#getGallery.Image_Name#" data-imagelightbox="a">
								<img src="admin\images\company\gallery\#getGallery.Company_ID#\#getGallery.Thumb_Name#" alt="" title="" >
							</a>--->
							<a href="##" data-imagelightbox="a" class="pop">
								<img src="admin\images\company\gallery\#getGallery.Company_ID#\#getGallery.Thumb_Name#" alt="" title="" id="imageresource" data-imgsrc="admin\images\company\gallery\#getGallery.Company_ID#\#getGallery.Image_Name#" data-imgdesc="#getGallery.Description#">
							</a>
						</div>
						<div class="description">
							#Left(getGallery.Description, 200)# <cfif len(getGallery.Description) gt 200>...</cfif>
						</div>
					</div>
				</cfloop>
				<div class="clear"></div>
			<cfelse>
				<div class="emptyPhoto">No Record found</div>
			</cfif>
		</div>
	</div>
	<!-- Creates the bootstrap modal where the image will appear -->
	<div class="modal fade" id="imagemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" style="margin-top: -10px;"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			
		  </div>
		   <div class="modal-body text-center">
		        <img src="" id="imagepreview" style="height: 245px; margin-top:10px;" >
				<div id="imagedescripton" style="margin-top:10px;text-align:center;"></div>
		      </div>
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		  </div>
		</div>
	  </div>
	</div>	
	<cfinclude template="#templatePath#template_footer.cfm">
</cfoutput>
<script>

	$( function()
	{
			// ACTIVITY INDICATOR
			disbaleClick();
		
		var activityIndicatorOn = function()
			{
				$( '<div id="imagelightbox-loading"><div></div></div>' ).appendTo( 'body' );
				
			},
			activityIndicatorOff = function()
			{
				$( '#imagelightbox-loading' ).remove();
			},


			// OVERLAY

			overlayOn = function()
			{
				$( '<div id="imagelightbox-overlay"></div>' ).appendTo( 'body' );
			},
			overlayOff = function()
			{
				$( '#imagelightbox-overlay' ).remove();
			},


			// CLOSE BUTTON

			closeButtonOn = function( instance )
			{
				$( '<button type="button" id="imagelightbox-close" title="Close"></button>' ).appendTo( 'body' ).on( 'click touchend', function(){ $( this ).remove(); instance.quitImageLightbox(); return false; });
			},
			closeButtonOff = function()
			{
				$( '#imagelightbox-close' ).remove();
			},


			// CAPTION

			captionOn = function()
			{
				var description = $( 'a[href="' + $( '#imagelightbox' ).attr( 'src' ) + '"] img' ).attr( 'alt' );
				if( description.length > 0 )
					$( '<div id="imagelightbox-caption">' + description + '</div>' ).appendTo( 'body' );
			},
			captionOff = function()
			{
				$( '#imagelightbox-caption' ).remove();
			},


			// NAVIGATION

			navigationOn = function( instance, selector )
			{
				var images = $( selector );
				
				if( images.length )
				{
					var nav = $( '<div id="imagelightbox-nav"></div>' );
					for( var i = 0; i < images.length; i++ )
						nav.append( '<button type="button"></button>' );

					nav.appendTo( 'body' );
					nav.on( 'click touchend', function(){ return false; });

					var navItems = nav.find( 'button' );
					navItems.on( 'click touchend', function()
					{
						var $this = $( this );
						if( images.eq( $this.index() ).attr( 'href' ) != $( '#imagelightbox' ).attr( 'src' ) )
							instance.switchImageLightbox( $this.index() );

						navItems.removeClass( 'active' );
						navItems.eq( $this.index() ).addClass( 'active' );				

						return false;
					})
					.on( 'touchend', function(){ return false; });
				}
			},
			navigationUpdate = function( selector )
			{
				var items = $( '#imagelightbox-nav button' );
				items.removeClass( 'active' );
				items.eq( $( selector ).filter( '[href="' + $( '#imagelightbox' ).attr( 'src' ) + '"]' ).index( selector ) ).addClass( 'active' );
			},
			navigationOff = function()
			{
				$( '#imagelightbox-nav' ).remove();
			},


			// ARROWS

			arrowsOn = function( instance, selector )
			{
				var $arrows = $( '<button type="button" class="imagelightbox-arrow imagelightbox-arrow-left"></button><button type="button" class="imagelightbox-arrow imagelightbox-arrow-right"></button>' );

				$arrows.appendTo( 'body' );

				$arrows.on( 'click touchend', function( e )
				{
					e.preventDefault();

					var $this	= $( this ),
						$target	= $( selector + '[href="' + $( '#imagelightbox' ).attr( 'src' ) + '"]' ),
						index	= $target.index( selector );

					if( $this.hasClass( 'imagelightbox-arrow-left' ) )
					{
						index = index - 1;
						if( !$( selector ).eq( index ).length )
							index = $( selector ).length;
					}
					else
					{
						index = index + 1;
						if( !$( selector ).eq( index ).length )
							index = 0;
					}

					instance.switchImageLightbox( index );
					return false;
				});
			},
			arrowsOff = function()
			{
				$( '.imagelightbox-arrow' ).remove();
			};


		//	WITH ACTIVITY INDICATION

		$( 'a[data-imagelightbox="a"]' ).imageLightbox(
		{
			onLoadStart:	function() { activityIndicatorOn(); },
			onLoadEnd:		function() { activityIndicatorOff(); },
			onEnd:	 		function() { activityIndicatorOff(); }
		});


		//	WITH OVERLAY & ACTIVITY INDICATION

		$( 'a[data-imagelightbox="b"]' ).imageLightbox(
		{
			onStart: 	 function() { overlayOn(); },
			onEnd:	 	 function() { overlayOff(); activityIndicatorOff(); },
			onLoadStart: function() { activityIndicatorOn(); },
			onLoadEnd:	 function() { activityIndicatorOff(); }
		});


		//	WITH "CLOSE" BUTTON & ACTIVITY INDICATION

		var instanceC = $( 'a[data-imagelightbox="c"]' ).imageLightbox(
		{
			quitOnDocClick:	false,
			onStart:		function() { closeButtonOn( instanceC ); },
			onEnd:			function() { closeButtonOff(); activityIndicatorOff(); },
			onLoadStart: 	function() { activityIndicatorOn(); },
			onLoadEnd:	 	function() { activityIndicatorOff(); }
		});


		//	WITH CAPTION & ACTIVITY INDICATION

		$( 'a[data-imagelightbox="d"]' ).imageLightbox(
		{
			onLoadStart: function() { captionOff(); activityIndicatorOn(); },
			onLoadEnd:	 function() { captionOn(); activityIndicatorOff(); },
			onEnd:		 function() { captionOff(); activityIndicatorOff(); }
		});


		//	WITH ARROWS & ACTIVITY INDICATION

		var selectorG = 'a[data-imagelightbox="g"]';
		var instanceG = $( selectorG ).imageLightbox(
		{
			onStart:		function(){ arrowsOn( instanceG, selectorG ); },
			onEnd:			function(){ arrowsOff(); activityIndicatorOff(); },
			onLoadStart: 	function(){ activityIndicatorOn(); },
			onLoadEnd:	 	function(){ $( '.imagelightbox-arrow' ).css( 'display', 'block' ); activityIndicatorOff(); }
		});


		//	WITH NAVIGATION & ACTIVITY INDICATION

		var selectorE = 'a[data-imagelightbox="e"]';
		var instanceE = $( selectorE ).imageLightbox(
		{
			onStart:	 function() { disbaleClick(); navigationOn( instanceE, selectorE ); },
			onEnd:		 function() { navigationOff(); activityIndicatorOff(); },
			onLoadStart: function() { activityIndicatorOn(); },
			onLoadEnd:	 function() { navigationUpdate( selectorE ); activityIndicatorOff(); }
		});


		//	ALL COMBINED

		var selectorF = 'a[data-imagelightbox="f"]';
		var instanceF = $( selectorF ).imageLightbox(
		{
			onStart:		function() { overlayOn(); closeButtonOn( instanceF ); arrowsOn( instanceF, selectorF ); },
			onEnd:			function() { overlayOff(); captionOff(); closeButtonOff(); arrowsOff(); activityIndicatorOff(); },
			onLoadStart: 	function() { captionOff(); activityIndicatorOn(); },
			onLoadEnd:	 	function() { captionOn(); activityIndicatorOff(); $( '.imagelightbox-arrow' ).css( 'display', 'block' ); }
		});
		$(".pop").on("click", function() {
		   console.log($(this).find('img').data('imgsrc'));
		   $('#imagepreview').attr('src', $(this).find('img').data('imgsrc')); // here asign the image to the modal when the user click the image link
		   $('#imagedescripton').html($(this).find('img').data('imgdesc'));
		   $('#imagemodal').modal('show'); // imagemodal is the id attribute assigned to the bootstrap modal, then use the show function
		});

	});
</script>

procedure(IPHlayCheckTextLabelj()

	cv=geGetEditCellView()
	
	geDeleteAllHilightSet(geGetWindowCellView())
	
	/*	
	hset0=geCreateHilightSet(geGetEditCellView() list("y1" "flight"))	
	info0="Labels not found!!"
	winBox=geGetWindowBox(hiGetCurrentWindow())
   edgeAdjustX=0.02 ; 2% of horizontal display size
   edgeAdjustY=0.04
   textAdjust=0.085 ; 2.3% of vertical display size
   x=leftEdge(winBox)+(rightEdge(winBox)-leftEdge(winBox))*edgeAdjustX
   y=topEdge(winBox)/2;*edgeAdjustY;topEdge(winBox)-(topEdge(winBox)-bottomEdge(winBox))*edgeAdjustY
   textSize2=(topEdge(winBox)-bottomEdge(winBox))*textAdjust
	geAddHilightLabel(hset0 x:y info0 "centerLeft" "R0" "roman" textSize2 t nil)
	hset0->enable=t	
	hiRegTimer("geDeleteHilightSet(hset0) geRefresh()" 30)
	*/
	
	textSize=1
	hset=geCreateHilightSet(geGetEditCellView() list("y1" "flight"))
	info="Labels not found!!"
	geAddHilightLabel(hset 8:-0.8 info "centerCenter" "R0" "roman" textSize t nil)
	hset->enable=t	
	
	;A=0

	
	foreach(Shape cv~>shapes

		/*
		if(Shape~>objType=="label" then
			if(Shapes~>theLabel==cv~>cellName
			then printf("with Label")
			else printf("no Label")
			);if
		
		else printf("no Label")	
		);if
		*/
		
		
		
		
		when(Shape~>theLabel==cv~>cellName
			;printf("with Label")
			;geDeleteAllHilightSet(geGetWindowCellView())
			geDeleteHilightSet(hset)		
			hset2=geCreateHilightSet(geGetEditCellView() list("y1" "drawing"))	
			info="Good job! Labels found!"
			
			
			;winBox=geGetWindowBox(hiGetCurrentWindow())
			;edgeAdjustX=0.02
      		;edgeAdjustY=0.04
			;x=rightEdge(winBox)/2*edgeAdjustX
      	    ;y=topEdge(winBox)/2*edgeAdjustY
			
		   winBox=geGetWindowBox(hiGetCurrentWindow())
		   edgeAdjustX=0.02 ; 2% of horizontal display size
	       edgeAdjustY=0.04
	       textAdjust=0.085 ; 2.3% of vertical display size
	       x=leftEdge(winBox)+(rightEdge(winBox)-leftEdge(winBox))*edgeAdjustX
	       y=topEdge(winBox)/2;*edgeAdjustY;topEdge(winBox)-(topEdge(winBox)-bottomEdge(winBox))*edgeAdjustY
	       textSize2=(topEdge(winBox)-bottomEdge(winBox))*textAdjust
			
			
			geAddHilightLabel(hset2 x:y info "centerLeft" "R0" "roman" textSize2 t nil)
			hset2->enable=t	
			hiRegTimer("geDeleteHilightSet(hset2) geRefresh()" 30)
			;A=1			
			);when
			
		;when(Shape~>theLabel==cv~>cellName
		;	printf("with Label")
		;	);when	
		
		
	);foreach
	
	/*
	when(A==1
		;geDeleteAllHilightSet(geGetWindowCellView())
		info="Good job! Labels found!"
		geAddHilightLabel(hset 8:-1.5 info "centerCenter" "R0" "roman" textSize t nil)
		hset->enable=t	
		hiRegTimer("geDeleteAllHilightSet(geGetWindowCellView()) geRefresh()" 10)
	);when
	*/
	
);procedure

procedure(IPHlayPVS_DRC()
	IPHlayCheckTextLabelj()
	_pvsOpenIPVSrunForm( 'drc ?timeout 30 )
	lxHiVerifyDesign()
	

);procedure

procedure(IPHlayPVS_LVS()
	IPHlayCheckTextLabelj()
	_pvsOpenIPVSrunForm( 'lvs ?timeout 30 )
	lxHiVerifyDesign()
	

);procedure

procedure( CCSattachLabels()
   let( (cv allLabels x1 y1 box inst)
      cv=geGetWindowCellView()
      allLabels=setof(x cv~>shapes x~>objType=="label")
      foreach( label allLabels
         x1=car(label~>xy)
         y1=cadr(label~>xy)
         box=list(x1:y1 x1+0.001:y1+0.001)
         inst=car(dbProduceOverlapInst(cv box))
         leAttachFig(label inst)
         printf("Attached label %s at %L to inst %s\n" label~>theLabel label~>xy inst~>name)
      ) ;foreach
   ) ;let
) ;procedure


with TextaccesseSchriftartGrafik;
with TextaccesseSchriftgroesseGrafik;
with TextaccesseSchriftfarbeGrafik;
with TextaccesseTextGrafik;

package body TextaccesseSetzenGrafik is
   
   procedure StandardSetzen
   is begin
      
      -- In allen Bereichen immer alles gleich anlegen, auch dann wenn es dann leer ist.
      -- So weiß ich immer ob ich alles durchgegangen bin.
      TextaccesseSchriftartGrafik.SchriftartSetzen;
      TextaccesseSchriftgroesseGrafik.SchriftgrößeSetzen;
      TextaccesseSchriftfarbeGrafik.SchriftfarbeSetzen;
      TextaccesseTextGrafik.TextSetzen;
      
   end StandardSetzen;

end TextaccesseSetzenGrafik;

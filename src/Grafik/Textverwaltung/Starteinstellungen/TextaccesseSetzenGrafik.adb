with TextaccesseSchriftgroesseGrafik;
with TextaccesseSchriftfarbeGrafik;
with TextaccesseTextGrafik;

package body TextaccesseSetzenGrafik is
   
   procedure StandardSetzen
   is begin
      
      -- In allen Bereichen immer alles gleich anlegen, auch dann wenn es dann leer ist.
      -- So weiß ich immer ob ich alles durchgegangen bin.
      -- Schriftart wird hier nicht mehr gesetzt, damit das System mit verschiedenen Fonts klarkommt, siehe dazu auch TexteinstellungenGrafik.SchriftartFestlegen.
      TextaccesseSchriftgroesseGrafik.SchriftgrößeSetzen;
      TextaccesseSchriftfarbeGrafik.SchriftfarbeSetzen;
      TextaccesseTextGrafik.TextSetzen;
      
   end StandardSetzen;

end TextaccesseSetzenGrafik;

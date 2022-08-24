pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TextaccesseSchriftartSetzenSFML;
with TextaccesseSchriftgroesseSetzenSFML;
with TextaccesseSchriftfarbeSetzenSFML;
with TextaccesseTextSetzenSFML;

package body TextaccesseAllesSetzenSFML is
   
   procedure AllesAufStandard
   is begin
      
      -- In allen Bereichen immer alles gleich anlegen, auch dann wenn es dann leer ist.
      -- So weiß ich immer ob ich alles durchgegangen bin.
      TextaccesseSchriftartSetzenSFML.SchriftartSetzen;
      TextaccesseSchriftgroesseSetzenSFML.SchriftgrößeSetzen;
      TextaccesseSchriftfarbeSetzenSFML.SchriftfarbeSetzen;
      TextaccesseTextSetzenSFML.TextSetzen;
      
   end AllesAufStandard;

end TextaccesseAllesSetzenSFML;

private with ZufallsgeneratorenHTSEB;

with KampfDatentypen;

package KampfberechnungenLogik is
   pragma Elaborate_Body;
   
   function Kampfberechnung
     (AngriffExtern : in KampfDatentypen.KampfwerteBasis;
      VerteidigungExtern : in KampfDatentypen.KampfwerteBasis)
      return Integer;
   
private
      
   ErfolgeAngreifer : Natural;
   ErfolgeVerteidiger : Natural;
   
   
   
   function Kampferfolge is new ZufallsgeneratorenHTSEB.ErreichteErfolge (GanzeZahl => KampfDatentypen.KampfwerteBasis);
   
end KampfberechnungenLogik;

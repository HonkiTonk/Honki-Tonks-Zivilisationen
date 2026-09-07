with Sf.System.Vector2;

private with UmwandlungssystemHTSEB;

private with KartenDatentypen;

package ZusatztextKartenebeneGrafik is
   pragma Elaborate_Body;

   function ZusatztextKartenebene
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
               and
                 RealeViewbreiteExtern >= 0.00
              ),
         
       Post => (
                  ZusatztextKartenebene'Result.x >= 0.00
                and
                  ZusatztextKartenebene'Result.y >= 0.00
               );
   
private
   
   Schleifenabzug : Natural;
   
   Trennbereich : constant Wide_Wide_String (1 .. 4) := " .. ";
   
   Textbreite : Float;
   
   Textposition : Sf.System.Vector2.sfVector2f;
                                         
   procedure TextFestlegen;
   
   
   
   function TextAnzeigen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
               and
                 RealeViewbreiteExtern >= 0.00
              ),
         
       Post => (
                  TextAnzeigen'Result.x >= 0.00
                and
                  TextAnzeigen'Result.y >= 0.00
               );
   
   function EbeneAlsString is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => KartenDatentypen.EbeneVorhanden);

end ZusatztextKartenebeneGrafik;

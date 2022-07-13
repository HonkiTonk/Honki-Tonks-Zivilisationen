pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;

package AllgemeineTextBerechnungenSFML is

   function TextMittelPositionErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
              );

   function TextViertelPositionErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      LinksRechtsExtern : in Boolean)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
              );
   
   function TextHalbeBreiteErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
              );
   
   function HalbeBildschirmhöhe
     return Float
     with
       Post => (
                  HalbeBildschirmhöhe'Result > 0.00
               );
   
   function AbstandZeilen
     return Float
     with
       Post => (
                  AbstandZeilen'Result > 0.00
               );
   
   function AbstandZeilenGroß
     return Float
     with
       Post => (
                  AbstandZeilenGroß'Result > 0.00
               );
   
   function AbstandÜberschrift
     return Float
     with
       Post => (
                  AbstandÜberschrift'Result > 0.00
               );
   
   function AbstandÜberschriftGroß
     return Float
     with
       Post => (
                  AbstandÜberschriftGroß'Result > 0.00
               );
   
private
   
   Position : Float;
   TextHalbeBreite : Float;
   
   PositionLogik : Float;
   TextHalbeBreiteLogik : Float;

end AllgemeineTextBerechnungenSFML;

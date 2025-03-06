with Sf.System.Vector2;

with StadtDatentypen;
with EinheitenDatentypen;
with ForschungenDatentypen;
with StadtRecords;
with MenueDatentypen;
with BefehleDatentypen;
with TastenbelegungDatentypen;

package MausauswahlLogik is
   pragma Elaborate_Body;
   use type EinheitenDatentypen.Transportplätze;
   use type StadtDatentypen.Bauprojektart_Enum;
   
   function SpeziesauswahlDiplomatie
     return Natural;
   
   function Forschungsmenü
     return ForschungenDatentypen.ForschungID;

   function Baumenü
     return StadtRecords.BauprojektauswahlRecord
     with
       Post => (
                (if Baumenü'Result.Bauauswahl /= 0 then Baumenü'Result.Bauprojektart = StadtDatentypen.Leer_Bauprojektart)
                and
                  (if Baumenü'Result.Bauprojektart /= StadtDatentypen.Leer_Bauprojektart then Baumenü'Result.Bauauswahl = 0)
               );
   
   function Menüs
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Natural
     with
       Pre => (
                 AnfangExtern <= EndeExtern
              );
   
   function JaNein
     return Natural
     with
       Post => (
                  JaNein'Result <= 2
               );
   
   function Steuerung
     return Integer;
   
   function Weltkartenbefehle
     return TastenbelegungDatentypen.Weltkartenbefehle_Enum;
   
   function Einheitenbefehle
     return BefehleDatentypen.Einheitenbelegung_Enum;
   
   function Stadtumgebung
     return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Stadtumgebung'Result.x >= -1.00
                and
                  Stadtumgebung'Result.y >= -1.00
               );
   
   function Stadtbefehle
     return BefehleDatentypen.Stadtbefehle_Enum;
   
   function Verkaufsmenü
     return StadtDatentypen.GebäudeID;
   
   function SpeichernLaden
     return Integer;
   
   function StadtEinheitauswahl
     (AnfangExtern : in EinheitenDatentypen.Transportplätze;
      EndeExtern : in EinheitenDatentypen.TransportplätzeVorhanden)
      return Integer
     with
       Pre => (
                 AnfangExtern < EndeExtern
              ),
         
       Post => (
                  StadtEinheitauswahl'Result >= -1
               );
   
   function Setauswahl
     (AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Natural
     with
       Pre => (
                 AnfangExtern <= EndeExtern
              );
   
private
      
   Mausposition : Sf.System.Vector2.sfVector2f;
    
end MausauswahlLogik;

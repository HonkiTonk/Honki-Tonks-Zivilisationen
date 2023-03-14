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
   use type StadtDatentypen.GebäudeIDMitNullwert;
   use type EinheitenDatentypen.EinheitenIDMitNullWert;
   use type EinheitenDatentypen.Transportplätze;

   function SpeziesauswahlDiplomatie
     return Natural;
   
   function Forschungsmenü
     return ForschungenDatentypen.ForschungIDMitNullWert;

   function Baumenü
     return StadtRecords.BauprojektRecord
     with
       Post => (
                (if Baumenü'Result.Gebäude /= 0 then Baumenü'Result.Einheit = 0)
                and
                  (if Baumenü'Result.Einheit /= 0 then Baumenü'Result.Gebäude = 0)
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
     return Natural;
   
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
     return StadtDatentypen.GebäudeIDMitNullwert;
   
   function SpeichernLaden
     return Natural;
   
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
   
   function Sprachenauswahl
     (AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Natural
     with
       Pre => (
                 AnfangExtern <= EndeExtern
              );
   
private
   
   Auflösung : Sf.System.Vector2.sfVector2u;
   
   Mausposition : Sf.System.Vector2.sfVector2f;
   
end MausauswahlLogik;

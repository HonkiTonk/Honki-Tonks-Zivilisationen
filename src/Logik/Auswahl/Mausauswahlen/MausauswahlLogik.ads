pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with StadtDatentypen; use StadtDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with ForschungenDatentypen;
with StadtRecords;
with MenueDatentypen;
with BefehleDatentypen;
with TastenbelegungDatentypen;

package MausauswahlLogik is
   pragma Elaborate_Body;

   function RassenauswahlDiplomatie
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
     return Sf.System.Vector2.sfVector2f;
   
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
   
   Mausposition : Sf.System.Vector2.sfVector2f;

end MausauswahlLogik;

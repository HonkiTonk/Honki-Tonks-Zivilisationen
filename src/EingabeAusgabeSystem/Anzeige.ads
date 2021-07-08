pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, GlobaleTexte;
use GlobaleDatentypen, GlobaleTexte;

package Anzeige is
   
   type AllgemeineAnzeigeTextRecord is record
      
      Text : Unbounded_Wide_Wide_String;
      Nummer : Natural;
      
   end record;
   
   -- Im Array immer die größte Auswahlfläche reinschreiben, damit es bei allen funktioniert.
   type AlgemeineAnzeigeTextArray is array (GlobaleDatentypen.KartenverbesserungEinheitenID'First + 1 .. GlobaleDatentypen.KartenverbesserungEinheitenID'Last) of AllgemeineAnzeigeTextRecord;
   AllgemeineAnzeigeText : AlgemeineAnzeigeTextArray;

   procedure AnzeigeOhneAuswahlNeu
     (ÜberschriftDateiExtern, TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern, LetzteZeileExtern : in Positive;
      AbstandAnfangExtern, AbstandMitteExtern, AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum)
     with
       Pre =>
         (ErsteZeileExtern <= LetzteZeileExtern
          and
            (if ÜberschriftDateiExtern = GlobaleTexte.Leer then ÜberschriftZeileExtern = 0)
          and
            (if ÜberschriftZeileExtern = 0 then ÜberschriftDateiExtern = GlobaleTexte.Leer)
          and
            TextDateiExtern /= GlobaleTexte.Leer);

   procedure EinzeiligeAnzeigeOhneAuswahl
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextZeileExtern : in Positive);

   procedure AnzeigeMitAuswahlNeu
     (FrageDateiExtern, TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern, ErsteZeileExtern, LetzteZeileExtern, AktuelleAuswahlExtern : in Natural)
     with
       Pre =>
         (ErsteZeileExtern <= LetzteZeileExtern
          and
            (if FrageDateiExtern = GlobaleTexte.Leer then FrageZeileExtern = 0)
          and
            (if FrageZeileExtern = 0 then FrageDateiExtern = GlobaleTexte.Leer)
          and
            TextDateiExtern /= GlobaleTexte.Leer);

   procedure AnzeigeSprache
     (AktuelleAuswahlExtern, ErsteZeileExtern, LetzteZeileExtern : in Positive)
     with
       Pre =>
         (ErsteZeileExtern <= LetzteZeileExtern);

   procedure AnzeigeLangerTextNeu
     (ÜberschriftDateiExtern, TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern, LetzteZeileExtern : in Positive;
      AbstandAnfangExtern, AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum)
     with
       Pre =>
         (ErsteZeileExtern <= LetzteZeileExtern
          and
            (if ÜberschriftDateiExtern = GlobaleTexte.Leer then ÜberschriftZeileExtern = 0)
          and
            (if ÜberschriftZeileExtern = 0 then ÜberschriftDateiExtern = GlobaleTexte.Leer)
          and
            TextDateiExtern /= GlobaleTexte.Leer);
   
   procedure AllgemeineAnzeige
     (AktuelleAuswahlExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID);

private
   
   Taste : Wide_Wide_Character;

   Zeichengrenze : constant Positive := 100;
   ZeichengrenzenMultiplikator : Positive;
      
   LängsterText : Integer;
   Wert : Integer;
   
   Teilung : Float;

   TextNeu : Unbounded_Wide_Wide_String;
   
   type WelcheDateienWelcheTexteRecord is record
            
      TextDatei : GlobaleDatentypen.TextDateien;

      TextAnfangZeile : GlobaleDatentypen.TextZeilen;
      TextEndeZeile : GlobaleDatentypen.TextZeilen;
      
   end record;
   
   type WelcheDateienWelcheTexteArray is array (0 .. 21, 0 .. 84) of WelcheDateienWelcheTexteRecord;
   WelcheDateienWelcheTexte : constant WelcheDateienWelcheTexteArray := (others => (others => (0, 0, 0)));

end Anzeige;

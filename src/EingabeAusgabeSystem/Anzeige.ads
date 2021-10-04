pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleTexte, EinheitStadtDatentypen;
use GlobaleTexte, EinheitStadtDatentypen;

package Anzeige is
   
   type AllgemeineAnzeigeTextRecord is record
      
      Text : Unbounded_Wide_Wide_String;
      Nummer : Natural;
      
   end record;
   
   -- Im Array immer die größte Auswahlfläche reinschreiben, damit es bei allen funktioniert.
   type AlgemeineAnzeigeTextArray is array (EinheitStadtDatentypen.MinimimMaximumID'First + 2 .. EinheitStadtDatentypen.MinimimMaximumID'Last) of AllgemeineAnzeigeTextRecord;
   AllgemeineAnzeigeText : AlgemeineAnzeigeTextArray;
   AktuelleAuswahl : EinheitStadtDatentypen.MinimimMaximumID;

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
      ErsteZeileExtern : in Positive;
      AbstandAnfangExtern, AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum)
     with
       Pre =>
         ((if ÜberschriftDateiExtern = GlobaleTexte.Leer then ÜberschriftZeileExtern = 0)
          and
            (if ÜberschriftZeileExtern = 0 then ÜberschriftDateiExtern = GlobaleTexte.Leer)
          and
            TextDateiExtern /= GlobaleTexte.Leer);
   
   procedure AllgemeineAnzeige
     (AktuelleAuswahlExtern : in EinheitStadtDatentypen.MinimimMaximumID);
   
   procedure AbstandEinbauen
     (AbstandExtern : in GlobaleTexte.Welcher_Abstand_Enum);

private
   
   Zeichengrenze : constant Positive := 100;
   ZeichengrenzenMultiplikator : Positive;
      
   LängsterText : Natural;
   
   TextNeu : Unbounded_Wide_Wide_String;
   
end Anzeige;

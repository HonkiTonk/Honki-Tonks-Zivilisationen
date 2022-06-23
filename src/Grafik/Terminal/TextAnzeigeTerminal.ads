pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleTexte; use GlobaleTexte;
with EinheitenDatentypen; use EinheitenDatentypen;

package TextAnzeigeTerminal is
   
   type AllgemeineAnzeigeTextRecord is record
      
      Text : Unbounded_Wide_Wide_String;
      Nummer : Natural;
      
   end record;
   
   -- Im Array immer die größte Auswahlfläche reinschreiben, damit es bei allen funktioniert.
   type AlgemeineAnzeigeTextArray is array (EinheitenDatentypen.EinheitenIDMitNullWert'First + 2 .. EinheitenDatentypen.EinheitenIDMitNullWert'Last) of AllgemeineAnzeigeTextRecord;
   AllgemeineAnzeigeText : AlgemeineAnzeigeTextArray;
   AktuelleAuswahl : EinheitenDatentypen.EinheitenIDMitNullWert;

   procedure AnzeigeOhneAuswahlNeu
     (ÜberschriftDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern : in Positive;
      LetzteZeileExtern : in Positive;
      AbstandAnfangExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandMitteExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum)
     with
       Pre => (
                 ErsteZeileExtern <= LetzteZeileExtern
               and
                 (if ÜberschriftDateiExtern = GlobaleTexte.Leer then ÜberschriftZeileExtern = 0)
               and
                 (if ÜberschriftZeileExtern = 0 then ÜberschriftDateiExtern = GlobaleTexte.Leer)
               and
                 TextDateiExtern /= GlobaleTexte.Leer
              );

   procedure EinzeiligeAnzeigeOhneAuswahl
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextZeileExtern : in Positive);

   procedure AnzeigeMitAuswahlNeu
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural;
      AktuelleAuswahlExtern : in Positive)
     with
       Pre => (
                 ErsteZeileExtern <= LetzteZeileExtern
               and
                 (if FrageDateiExtern = GlobaleTexte.Leer then FrageZeileExtern = 0)
               and
                 (if FrageZeileExtern = 0 then FrageDateiExtern = GlobaleTexte.Leer)
               and
                 TextDateiExtern /= GlobaleTexte.Leer
              );

   procedure AnzeigeLangerTextNeu
     (ÜberschriftDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern : in Positive;
      AbstandAnfangExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum)
     with
       Pre => (
               (if ÜberschriftDateiExtern = GlobaleTexte.Leer then ÜberschriftZeileExtern = 0)
               and
                 (if ÜberschriftZeileExtern = 0 then ÜberschriftDateiExtern = GlobaleTexte.Leer)
               and
                 TextDateiExtern /= GlobaleTexte.Leer
              );
   
   procedure AllgemeineAnzeige
     (AktuelleAuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert);

private
      
   Zeichengrenze : constant Positive := 100;
   ZeichengrenzenMultiplikator : Positive;
      
   LängsterText : Natural;
   
   TextNeu : Unbounded_Wide_Wide_String;
   
   procedure AnzeigeMitAuswahl
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural;
      AktuelleAuswahlExtern : in Positive)
     with
       Pre => (
                 ErsteZeileExtern <= LetzteZeileExtern
               and
                 (if FrageDateiExtern = GlobaleTexte.Leer then FrageZeileExtern = 0)
               and
                 (if FrageZeileExtern = 0 then FrageDateiExtern = GlobaleTexte.Leer)
               and
                 TextDateiExtern /= GlobaleTexte.Leer
              );

   procedure AnzeigeOhneAuswahl
     (ÜberschriftDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern : in Positive;
      LetzteZeileExtern : in Positive;
      AbstandAnfangExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandMitteExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum);

   procedure AbstandEinbauen
     (AbstandExtern : in GlobaleTexte.Welcher_Abstand_Enum);

   procedure Überschrift
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural);
      
end TextAnzeigeTerminal;

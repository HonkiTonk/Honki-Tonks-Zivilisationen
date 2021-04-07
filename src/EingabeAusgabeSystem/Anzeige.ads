pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package Anzeige is
   
   type TextBauenRecord is record
      
      Text : Unbounded_Wide_Wide_String;
      Nummer : Natural;
      
   end record;

   type TextBauenNeuArray is array (GlobaleDatentypen.KartenverbesserungEinheitenID'First + 1 .. GlobaleDatentypen.KartenverbesserungEinheitenID'Last) of TextBauenRecord;
   TextBauenNeu : TextBauenNeuArray;

   type TextForschungRecord is record
      
      Text : Unbounded_Wide_Wide_String;
      Nummer : ForschungIDMitNullWert;
      
   end record;
   
   type TextForschungNeuArray is array (GlobaleDatentypen.ForschungID'Range) of TextForschungRecord;
   TextForschungNeu : TextForschungNeuArray;

   type TextTransporterRecord is record
      
      Text : Unbounded_Wide_Wide_String;
      Nummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      
   end record;

   type TextTransporterArray is array (GlobaleRecords.TransporterArray'First - 1 .. GlobaleRecords.TransporterArray'Last) of TextTransporterRecord;
   TextTransporter : TextTransporterArray;

   procedure AnzeigeOhneAuswahlNeu
     (ÜberschriftDateiExtern, TextDateiExtern : in GlobaleDatentypen.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern, LetzteZeileExtern : in Positive;
      AbstandAnfangExtern, AbstandMitteExtern, AbstandEndeExtern : in GlobaleDatentypen.Welcher_Abstand_Enum)
     with
       Pre => (ErsteZeileExtern <= LetzteZeileExtern and (if ÜberschriftDateiExtern = GlobaleDatentypen.Leer then ÜberschriftZeileExtern = 0)
               and (if ÜberschriftZeileExtern = 0 then ÜberschriftDateiExtern = GlobaleDatentypen.Leer) and TextDateiExtern /= GlobaleDatentypen.Leer);

   procedure EinzeiligeAnzeigeOhneAuswahl
     (TextDateiExtern : in GlobaleDatentypen.Welche_Datei_Enum;
      TextZeileExtern : in Positive);

   procedure AnzeigeMitAuswahlNeu
     (FrageDateiExtern, TextDateiExtern : in GlobaleDatentypen.Welche_Datei_Enum;
      FrageZeileExtern, ErsteZeileExtern, LetzteZeileExtern, AktuelleAuswahlExtern : in Natural)
     with
       Pre => (ErsteZeileExtern <= LetzteZeileExtern and (if FrageDateiExtern = GlobaleDatentypen.Leer then FrageZeileExtern = 0) and (if FrageZeileExtern = 0 then FrageDateiExtern = GlobaleDatentypen.Leer)
               and TextDateiExtern /= GlobaleDatentypen.Leer);

   procedure AnzeigeSprache
     (AktuelleAuswahlExtern, ErsteZeileExtern, LetzteZeileExtern : in Positive)
     with
       Pre => (ErsteZeileExtern <= LetzteZeileExtern);

   procedure AnzeigeStadt
     (AktuelleAuswahlExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID);

   procedure AnzeigeForschungNeu
     (AktuelleAuswahlExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID)
     with
       Pre => (AktuelleAuswahlExtern <= GlobaleDatentypen.ForschungID'Last);

   procedure AnzeigeTransporter
     (AktuelleAuswahlExtern : in Natural);

   procedure AnzeigeLangerTextNeu
     (ÜberschriftDateiExtern, TextDateiExtern : in GlobaleDatentypen.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern, LetzteZeileExtern : in Positive;
      AbstandAnfangExtern, AbstandEndeExtern : in GlobaleDatentypen.Welcher_Abstand_Enum)
     with
       Pre => (ErsteZeileExtern <= LetzteZeileExtern and (if ÜberschriftDateiExtern = GlobaleDatentypen.Leer then ÜberschriftZeileExtern = 0) and (if ÜberschriftZeileExtern = 0 then ÜberschriftDateiExtern = GlobaleDatentypen.Leer)
               and TextDateiExtern /= GlobaleDatentypen.Leer);

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

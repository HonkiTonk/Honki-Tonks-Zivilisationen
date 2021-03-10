pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, GlobaleDatentypen;
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

   procedure AnzeigeStadt (AktuelleAuswahl : in GlobaleDatentypen.KartenverbesserungEinheitenID);
   procedure AnzeigeLangerTextNeu (ÜberschriftDatei, TextDatei : in GlobaleDatentypen.WelcheDatei_Enum; ÜberschriftZeile : in Natural; ErsteZeile, LetzteZeile : in Positive;
                                   AbstandAnfang, AbstandEnde : in GlobaleDatentypen.WelcherAbstand_Enum) with
     Pre => (ErsteZeile <= LetzteZeile and (if ÜberschriftDatei = GlobaleDatentypen.Leer then ÜberschriftZeile = 0) and (if ÜberschriftZeile = 0 then ÜberschriftDatei = GlobaleDatentypen.Leer)
             and TextDatei /= GlobaleDatentypen.Leer);

   procedure AnzeigeForschungNeu (AktuelleAuswahl : in GlobaleDatentypen.KartenverbesserungEinheitenID) with
     Pre => (AktuelleAuswahl <= GlobaleDatentypen.ForschungID'Last);

   procedure AnzeigeSprache (AktuelleAuswahl, ErsteZeile, LetzteZeile : in Positive) with
     Pre => (ErsteZeile <= LetzteZeile);

   procedure AnzeigeOhneAuswahlNeu (ÜberschriftDatei, TextDatei : in GlobaleDatentypen.WelcheDatei_Enum; ÜberschriftZeile : in Natural; ErsteZeile, LetzteZeile : in Positive;
                                    AbstandAnfang, AbstandMitte, AbstandEnde : in GlobaleDatentypen.WelcherAbstand_Enum) with
     Pre => (ErsteZeile <= LetzteZeile and (if ÜberschriftDatei = GlobaleDatentypen.Leer then ÜberschriftZeile = 0) and (if ÜberschriftZeile = 0 then ÜberschriftDatei = GlobaleDatentypen.Leer)
             and TextDatei /= GlobaleDatentypen.Leer);

   procedure EinzeiligeAnzeigeOhneAuswahl (TextDatei : in GlobaleDatentypen.WelcheDatei_Enum; TextZeile : in Positive);

   procedure AnzeigeMitAuswahlNeu (FrageDatei, TextDatei : in GlobaleDatentypen.WelcheDatei_Enum; FrageZeile, ErsteZeile, LetzteZeile, AktuelleAuswahl : in Natural) with
     Pre => (ErsteZeile <= LetzteZeile and (if FrageDatei = GlobaleDatentypen.Leer then FrageZeile = 0) and (if FrageZeile = 0 then FrageDatei = GlobaleDatentypen.Leer) and TextDatei /= GlobaleDatentypen.Leer);

private
   
   Taste : Wide_Wide_Character;

   Zeichengrenze : constant Positive := 100;
      
   LängsterText : Integer;
   Wert : Integer;
   N : Integer;
   
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

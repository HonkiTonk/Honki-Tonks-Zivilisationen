pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with SystemDatentypen;
with GlobaleTexte;

package AuswahlMenue is

   function AuswahlMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;

private

   -- Mit dem neuen Menüsystem sollte das jetzt als Konstante möglich sein.
   Anfang : constant Positive := 1;

   Ende : Positive;

   AktuelleAuswahl : Natural := 1;

   RückgabeWert : SystemDatentypen.Rückgabe_Werte_Enum;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   -- Zweite Dimension wird hier nicht benötigt da es hier immer bei eins startet.
   type EndeMenüArray is array (SystemDatentypen.Menü_Ohne_Mit_Überschrift'Range) of Positive;
   EndeMenü : constant EndeMenüArray := (
                                           -- Minus ein beim hauptmenü, da dort noch auf Wiedersehen eingebaut ist wegen der Konsole.
                                           SystemDatentypen.Haupt_Menü_Enum => GlobaleTexte.Hauptmenü'Last - 1,
                                           SystemDatentypen.Spiel_Menü_Enum => GlobaleTexte.Spielmenü'Last,
                                           -------------------------------
                                           others => 1
                                          );

   procedure Auswahl
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum);

   function MausAuswahl
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum)
      return Natural;

end AuswahlMenue;

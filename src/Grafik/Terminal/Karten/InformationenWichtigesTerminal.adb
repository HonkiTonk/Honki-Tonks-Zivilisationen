pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Integer_Wide_Wide_Text_IO;

with LeseWichtiges;

with ForschungsbeschreibungenSFML;

package body InformationenWichtigesTerminal is
   
   procedure Wichtiges
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Allgemeine Informationen über die eigene Rasse, immer sichtbar
      Rundenanzahl;
      Geldmenge (RasseExtern => RasseExtern);
      GeldGewinn (RasseExtern => RasseExtern);
      Forschungsprojekt (RasseExtern => RasseExtern);
      Forschungszeit (RasseExtern => RasseExtern);
      Forschungsmenge (RasseExtern => RasseExtern);
      Forschungsrate (RasseExtern => RasseExtern);
      
   end Wichtiges;
   
   

   procedure Rundenanzahl
   is begin
      
     -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 33,
     --                                           LetzteZeileExtern      => 33,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Leer,
     --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => SpielVariablen.Allgemeines.Rundenanzahl,
                                         Width => 1);
      
   end Rundenanzahl;
     
     
   
   procedure Geldmenge
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
     -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 34,
     --                                           LetzteZeileExtern      => 34,
     --                                           AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
     --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
     --                                           AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => LeseWichtiges.Geldmenge (RasseExtern => RasseExtern),
                                         Width => 1);
      
   end Geldmenge;
     
     
     
   procedure GeldGewinn
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
     -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 35,
     --                                           LetzteZeileExtern      => 35,
     --                                           AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
     --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
     --                                           AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseExtern)),
                                         Width => 1);
      New_Line;
      
   end GeldGewinn;
     
     
     
     
   procedure Forschungsprojekt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
    --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
    --                                            TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 38,
    --                                           LetzteZeileExtern      => 38,
    --                                            AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
    --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
    --                                           AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Put_Line (Item => ForschungsbeschreibungenSFML.BeschreibungKurz (IDExtern    => LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern),
                                                             RasseExtern => RasseExtern));
                
   end Forschungsprojekt;
   
                
          
   procedure Forschungszeit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
    --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 36,
      --                                          LetzteZeileExtern      => 36,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (LeseWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern)),
                                         Width => 1);
      New_Line;
      
   end Forschungszeit;
          
     
     
   procedure Forschungsmenge
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
    --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
   --                                             TextDateiExtern        => GlobaleTexte.Zeug,
    --                                            ÜberschriftZeileExtern => 0,
    --                                            ErsteZeileExtern       => 39,
    --                                            LetzteZeileExtern      => 39,
    --                                            AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
    --                                            AbstandMitteExtern     => GlobaleTexte.Leer,
    --                                            AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern)),
                                         Width => 1);
      
   end Forschungsmenge;
     
     
     
   procedure Forschungsrate
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
    --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
    --                                            TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
    --                                            ErsteZeileExtern       => 37,
     --                                           LetzteZeileExtern      => 37,
     --                                           AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
     --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
     --                                           AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseExtern)),
                                         Width => 1);
      New_Line (Spacing => 2);
      
   end Forschungsrate;

end InformationenWichtigesTerminal;

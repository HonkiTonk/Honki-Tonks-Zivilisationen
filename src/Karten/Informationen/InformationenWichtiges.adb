pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Integer_Text_IO;

with GlobaleTexte;

with LeseWichtiges;

with Anzeige;
with ForschungAllgemein;

package body InformationenWichtiges is
   
   procedure Wichtiges
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Allgemeine Informationen über die eigene Rasse, immer sichtbar
      InformationenWichtiges.Rundenanzahl;
      InformationenWichtiges.Geldmenge (RasseExtern => RasseExtern);
      InformationenWichtiges.GeldGewinn (RasseExtern => RasseExtern);
      InformationenWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      InformationenWichtiges.Forschungszeit (RasseExtern => RasseExtern);
      InformationenWichtiges.Forschungsmenge (RasseExtern => RasseExtern);
      InformationenWichtiges.Forschungsrate (RasseExtern => RasseExtern);
      
   end Wichtiges;
   
   

   procedure Rundenanzahl
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 33,
                                     LetzteZeileExtern      => 33,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => GlobaleVariablen.RundenAnzahl,
                               Width => 1);
      
   end Rundenanzahl;
     
     
   
   procedure Geldmenge
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 34,
                                     LetzteZeileExtern      => 34,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => LeseWichtiges.Geldmenge (RasseExtern => RasseExtern),
                               Width => 1);
      
   end Geldmenge;
     
     
     
   procedure GeldGewinn
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 35,
                                     LetzteZeileExtern      => 35,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseExtern)),
                               Width => 1);
      New_Line;
      
   end GeldGewinn;
     
     
     
     
   procedure Forschungsprojekt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 38,
                                     LetzteZeileExtern      => 38,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      ForschungAllgemein.Beschreibung (IDExtern         => LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern),
                                       TextAccessExtern => null);
      
   end Forschungsprojekt;
     
     
          
   procedure Forschungszeit
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 36,
                                     LetzteZeileExtern      => 36,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (LeseWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern)),
                               Width => 1);
      New_Line;
      
   end Forschungszeit;
          
     
     
   procedure Forschungsmenge
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 39,
                                     LetzteZeileExtern      => 39,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern)),
                               Width => 1);
      
   end Forschungsmenge;
     
     
     
   procedure Forschungsrate
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 37,
                                     LetzteZeileExtern      => 37,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseExtern)),
                               Width => 1);
      New_Line (Spacing => 2);
      
   end Forschungsrate;

end InformationenWichtiges;

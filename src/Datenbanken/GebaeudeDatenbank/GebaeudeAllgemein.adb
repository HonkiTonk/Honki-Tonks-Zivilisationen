pragma SPARK_Mode (On);

with GlobaleTexte;

with GebaeudeDatenbank;

with Anzeige, WichtigesSetzen;

package body GebaeudeAllgemein is

   procedure Beschreibung
     (IDExtern : in GebäudeID)
   is begin
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Beschreibungen_Gebäude_Kurz,
                                            TextZeileExtern => Positive (IDExtern));

      -- Hier wichtige Werte einfügen
      -- Hier dann eine lange Textanzeige für eine Beschreibung des Gebäudes? Das auch für die Einheiten/Verbesserungen machen?
      
   end Beschreibung;
   
   

   procedure GebäudeProduktionBeenden
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GebäudeID)
   is begin     
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (IDExtern) := True;
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt := 0;
      
      PermanenteKostenDurchGebäudeÄndern (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                          IDExtern                => IDExtern,
                                          VorzeichenWechselExtern => 1);
                  
   end GebäudeProduktionBeenden;
   
   
   
   procedure GebäudeEntfernen     
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WelchesGebäudeExtern : in GlobaleDatentypen.GebäudeID)
   is begin
      
      WichtigesSetzen.GeldFestlegen (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                     GeldZugewinnExtern => Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, WelchesGebäudeExtern).PreisGeld) / 2);
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (WelchesGebäudeExtern) := False;
      
      PermanenteKostenDurchGebäudeÄndern (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                            IDExtern                => WelchesGebäudeExtern,
                                            VorzeichenWechselExtern => -1);
      
   end GebäudeEntfernen;
   
   

   procedure PermanenteKostenDurchGebäudeÄndern
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.GebäudeID;
      VorzeichenWechselExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in GlobaleDatentypen.PermanenteKostenArray'Range loop
         
         if
           GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, IDExtern).PermanenteKosten (PermanenteKostenSchleifenwert) <= 0
         then
            null;
               
         elsif
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (PermanenteKostenSchleifenwert)
           + GesamtePermanenteKosten (VorzeichenWechselExtern) * GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, IDExtern).PermanenteKosten (PermanenteKostenSchleifenwert) < 0
         then
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (PermanenteKostenSchleifenwert) := 0;
               
         elsif
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (PermanenteKostenSchleifenwert)
           + GesamtePermanenteKosten (VorzeichenWechselExtern) * GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, IDExtern).PermanenteKosten (PermanenteKostenSchleifenwert)
           > GlobaleDatentypen.GesamtePermanenteKosten'Last
         then
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (PermanenteKostenSchleifenwert) := GlobaleDatentypen.GesamtePermanenteKosten'Last;
               
         else
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (PermanenteKostenSchleifenwert)
              := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (PermanenteKostenSchleifenwert)
              + GesamtePermanenteKosten (VorzeichenWechselExtern) * GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, IDExtern).PermanenteKosten (PermanenteKostenSchleifenwert);
         end if;
         
      end loop PermanenteKostenSchleife;
      
   end PermanenteKostenDurchGebäudeÄndern;

end GebaeudeAllgemein;

with ProduktionDatentypen;

with SchreibeWichtiges;
with SchreibeStadtGebaut;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;

with GebaeudeumgebungLogik;
with StadtproduktionLogik;
with ForschungstestsLogik;

package body GebaeudeAllgemeinLogik is

   procedure GebäudeProduktionBeenden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
   is begin
      
      SchreibeStadtGebaut.Ressourcen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                      RessourcenExtern       => StadtKonstanten.LeerRessourcen,
                                      ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                      BauprojektExtern       => StadtKonstanten.LeerBauprojekt);
      SchreibeStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern     => StadtSpeziesNummerExtern,
                                             WelchesGebäudeExtern       => IDExtern,
                                             HinzufügenEntfernenExtern  => True);
      
      PermanenteKostenDurchGebäudeÄndern (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                            IDExtern                => IDExtern,
                                            VorzeichenWechselExtern => 1);
                  
   end GebäudeProduktionBeenden;
   
   
   
   procedure UmgebungsreduktionGebäudeEntfernen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         if
           False = LeseStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                      WelchesGebäudeExtern  => GebäudeSchleifenwert)
         then
            null;
            
         elsif
           True = GebaeudeumgebungLogik.RichtigeUmgebungVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                   GebäudeIDExtern        => GebäudeSchleifenwert)
         then
            null;
            
         else
            SchreibeStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern     => StadtSpeziesNummerExtern,
                                                   WelchesGebäudeExtern      => GebäudeSchleifenwert,
                                                   HinzufügenEntfernenExtern => False);
            
            PermanenteKostenDurchGebäudeÄndern (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                                  IDExtern                => GebäudeSchleifenwert,
                                                  VorzeichenWechselExtern => -1);
            
         end if;
         
      end loop GebäudeSchleife;
      
   end UmgebungsreduktionGebäudeEntfernen;
   
   
   
   procedure GebäudeEntfernen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeID)
   is begin
      
      SchreibeWichtiges.Geldmenge (SpeziesExtern         => StadtSpeziesNummerExtern.Spezies,
                                   GeldZugewinnExtern  => Integer (LeseGebaeudeDatenbank.PreisGeld (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                                    IDExtern    => WelchesGebäudeExtern)) / 2,
                                   RechnenSetzenExtern => True);
      
      SchreibeStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern     => StadtSpeziesNummerExtern,
                                             WelchesGebäudeExtern      => WelchesGebäudeExtern,
                                             HinzufügenEntfernenExtern => False);
      
      PermanenteKostenDurchGebäudeÄndern (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                            IDExtern                => WelchesGebäudeExtern,
                                            VorzeichenWechselExtern => -1);
      
   end GebäudeEntfernen;
   
   

   procedure PermanenteKostenDurchGebäudeÄndern
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID;
      -- Der Vorzeichenwechsel wird benötigt um auch bei Entfernung von Gebäuden die permanenten Kosten korrekt zu ändern
      VorzeichenWechselExtern : in KartenDatentypen.UmgebungsbereichEins)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in StadtRecords.PermanenteKostenArray'Range loop
         
         SchreibeStadtGebaut.PermanenteKostenPosten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     WelcherPostenExtern    => PermanenteKostenSchleifenwert,
                                                     KostenExtern           => ProduktionDatentypen.Stadtproduktion (VorzeichenWechselExtern)
                                                     * LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern        => StadtSpeziesNummerExtern.Spezies,
                                                                                               IDExtern           => IDExtern,
                                                                                               WelcheKostenExtern => PermanenteKostenSchleifenwert),
                                                     ÄndernSetzenExtern    => True);
         
      end loop PermanenteKostenSchleife;
      
      StadtproduktionLogik.Stadtproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
   end PermanenteKostenDurchGebäudeÄndern;
   
   
   
   -- Sollte ein Gebäude für eine Spezies nicht existieren dann einfach die Forschugnsanforderungen auf -1 setzen.
   function GebäudeAnforderungenErfüllt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
   is begin
            
      case
        LeseStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                           WelchesGebäudeExtern  => IDExtern)
      is
         when True =>
            return False;
            
         when False =>
            null;
      end case;
      
      case
        GebaeudeumgebungLogik.RichtigeUmgebungVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                         GebäudeIDExtern        => IDExtern)
      is
         when False =>
            return False;
            
         when True =>
            return ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern       => StadtSpeziesNummerExtern.Spezies,
                                                              TechnologieExtern => LeseGebaeudeDatenbank.Anforderungen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                                                        IDExtern    => IDExtern));
      end case;
      
   end GebäudeAnforderungenErfüllt;

end GebaeudeAllgemeinLogik;

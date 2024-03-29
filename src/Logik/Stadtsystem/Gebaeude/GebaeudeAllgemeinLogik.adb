with ProduktionKonstanten;

with SchreibeWichtiges;
with SchreibeStadtGebaut;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;

with GebaeudeanforderungenLogik;
with StadtproduktionLogik;

package body GebaeudeAllgemeinLogik is

   procedure GebäudeProduktionBeenden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeIDVorhanden)
   is begin
      
      SchreibeStadtGebaut.Material (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                    MaterialExtern           => StadtKonstanten.LeerMaterial,
                                    ÄndernSetzenExtern       => False);
      SchreibeStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                      BauprojektExtern         => StadtKonstanten.LeerBauprojekt);
      SchreibeStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                             WelchesGebäudeExtern      => IDExtern,
                                             HinzufügenEntfernenExtern => True);
      
      PermanenteKostenDurchGebäudeÄndern (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                            IDExtern                 => IDExtern,
                                            VorzeichenwechselExtern  => ProduktionKonstanten.VorzeichenPositiv);
      
   end GebäudeProduktionBeenden;
   
   
   
   procedure UmgebungsreduktionGebäudeEntfernen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeIDVorhanden'Range loop
         
         if
           False = LeseStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                      WelchesGebäudeExtern     => GebäudeSchleifenwert)
         then
            null;
            
         elsif
           True = GebaeudeanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                    IDExtern                 => GebäudeSchleifenwert)
         then
            null;
            
         else
            SchreibeStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                                   WelchesGebäudeExtern      => GebäudeSchleifenwert,
                                                   HinzufügenEntfernenExtern => False);
            
            PermanenteKostenDurchGebäudeÄndern (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                  IDExtern                 => GebäudeSchleifenwert,
                                                  VorzeichenwechselExtern  => ProduktionKonstanten.VorzeichenNegativ);
            
         end if;
         
      end loop GebäudeSchleife;
      
   end UmgebungsreduktionGebäudeEntfernen;
   
   
   
   procedure GebäudeVerkaufen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden)
   is begin
      
      SchreibeWichtiges.Geldmenge (SpeziesExtern       => StadtSpeziesNummerExtern.Spezies,
                                   GeldZugewinnExtern  => Integer (LeseGebaeudeDatenbank.PreisGeld (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                                    IDExtern      => WelchesGebäudeExtern)) / 2,
                                   RechnenSetzenExtern => True);
      
      SchreibeStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern   => StadtSpeziesNummerExtern,
                                             WelchesGebäudeExtern      => WelchesGebäudeExtern,
                                             HinzufügenEntfernenExtern => False);
      
      PermanenteKostenDurchGebäudeÄndern (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                            IDExtern                 => WelchesGebäudeExtern,
                                            VorzeichenwechselExtern  => ProduktionKonstanten.VorzeichenNegativ);
      
   end GebäudeVerkaufen;
   
   

      -- Der Vorzeichenwechsel wird benötigt um auch bei Entfernung von Gebäuden die permanenten Kosten korrekt zu ändern
   procedure PermanenteKostenDurchGebäudeÄndern
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeIDVorhanden;
      VorzeichenwechselExtern : in ProduktionDatentypen.Vorzeichenwechsel)
   is begin
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in StadtRecords.PermanenteKostenArray'Range loop
         
         SchreibeStadtGebaut.PermanenteKostenPosten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     WelcherPostenExtern      => PermanenteKostenSchleifenwert,
                                                     KostenExtern             => VorzeichenwechselExtern * LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                                                                                                   IDExtern           => IDExtern,
                                                                                                                                                   WelcheKostenExtern => PermanenteKostenSchleifenwert),
                                                     ÄndernSetzenExtern       => True);
         
      end loop PermanenteKostenSchleife;
      
      StadtproduktionLogik.Stadtproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
   end PermanenteKostenDurchGebäudeÄndern;

end GebaeudeAllgemeinLogik;

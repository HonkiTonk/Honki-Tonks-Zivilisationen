with WichtigesKonstanten;
with KampfDatentypen;
with StadtArrays;

with KIKonstanten;

with LeseGebaeudeDatenbank;
with LeseStadtGebaut;
with LeseWichtiges;

with GebaeudeanforderungenLogik;
with KIKriegErmittelnLogik;

package body KIGebaeudeBauenLogik is

   function GebäudeBauen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KIRecords.GebäudeIDBewertungRecord
   is
      use type KIDatentypen.BauenBewertung;
      use type StadtDatentypen.GebäudeID;
   begin
      
      GebäudeBewertet := KIKonstanten.LeerGebäudebewertung;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtArrays.GebäudeArray'Range loop
         
         case
           GebaeudeanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                             IDExtern                 => GebäudeSchleifenwert)
         is
            when True =>
               Gebäudewertung := GebäudeBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                    IDExtern                 => GebäudeSchleifenwert);
               
               if
                 Gebäudewertung < KIKonstanten.LeerBewertung
               then
                  null;
                     
               elsif
                 GebäudeBewertet.ID = StadtKonstanten.LeerGebäudeID
                 or
                   GebäudeBewertet.Bewertung < Gebäudewertung
               then
                  GebäudeBewertet := (GebäudeSchleifenwert, Gebäudewertung);

               else
                  null;
               end if;

            when False =>
               null;
         end case;
         
      end loop GebäudeSchleife;
      
      return GebäudeBewertet;
      
   end GebäudeBauen;
   
   
   
   function GebäudeBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
   begin
      
      Gesamtwertung := KIKonstanten.LeerBewertung;
      
      Gesamtwertung := Gesamtwertung + NahrungsproduktionBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                   IDExtern                 => IDExtern);
      Gesamtwertung := Gesamtwertung + GeldproduktionBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                               IDExtern                 => IDExtern);
      Gesamtwertung := Gesamtwertung + WissensgewinnBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                              IDExtern                 => IDExtern);
      Gesamtwertung := Gesamtwertung + MaterialproduktionBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                   IDExtern                 => IDExtern);
      Gesamtwertung := Gesamtwertung + VerteidigungBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                             IDExtern                 => IDExtern);
      Gesamtwertung := Gesamtwertung + AngriffBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                        IDExtern                 => IDExtern);
      Gesamtwertung := Gesamtwertung + KostenBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                       IDExtern                 => IDExtern);
      
      return Gesamtwertung;
            
   end GebäudeBewerten;
   
   
   
   function NahrungsproduktionBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return KIDatentypen.BauenBewertung
   is
      use type ProduktionDatentypen.Produktion;
      use type KIDatentypen.BauenBewertung;
   begin
      
      Produktion := LeseStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      Produktionsbonus := LeseGebaeudeDatenbank.Produktionsbonus (SpeziesExtern          => StadtSpeziesNummerExtern.Spezies,
                                                                  IDExtern               => IDExtern,
                                                                  ProduktionsbonusExtern => ProduktionDatentypen.Nahrung_Enum);
      PermanenteKosten := LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                  IDExtern           => IDExtern,
                                                                  WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum);
      
      if
        Produktion < StadtKonstanten.LeerNahrungsproduktion
        and
          StadtKonstanten.LeerNahrungsproduktion < Produktion + Produktionsbonus
      then
         return 20;
         
      elsif
        Produktion < StadtKonstanten.LeerNahrungsproduktion
        and
          Produktionsbonus > StadtKonstanten.LeerNahrungsproduktion
      then
         return 10;
         
      elsif
        Produktion < StadtKonstanten.LeerNahrungsproduktion
        and
          StadtKonstanten.LeerNahrungsproduktion = Produktionsbonus
      then
         return 5;
      
      elsif
        StadtKonstanten.LeerNahrungsproduktion >= Produktion - PermanenteKosten
      then
         return -20;
         
      else
         return KIDatentypen.BauenBewertung (Produktionsbonus - PermanenteKosten);
      end if;
      
   end NahrungsproduktionBewerten;
   
   
   
   function GeldproduktionBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return KIDatentypen.BauenBewertung
   is
      use type ProduktionDatentypen.Produktion;
      use type KIDatentypen.BauenBewertung;
   begin
      
      Produktion := LeseWichtiges.GeldRundengewinn (SpeziesExtern => StadtSpeziesNummerExtern.Spezies);
      Produktionsbonus := LeseGebaeudeDatenbank.Produktionsbonus (SpeziesExtern          => StadtSpeziesNummerExtern.Spezies,
                                                                  IDExtern               => IDExtern,
                                                                  ProduktionsbonusExtern => ProduktionDatentypen.Geld_Enum);
      PermanenteKosten := LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                  IDExtern           => IDExtern,
                                                                  WelcheKostenExtern => ProduktionDatentypen.Geld_Enum);
      
      if
        Produktion < WichtigesKonstanten.LeerGeldZugewinnProRunde
        and
          WichtigesKonstanten.LeerGeldZugewinnProRunde < Produktion + Produktionsbonus
      then
         return 20;
         
      elsif
        Produktion < WichtigesKonstanten.LeerGeldZugewinnProRunde
        and
          Produktionsbonus > StadtKonstanten.LeerGeldgewinnung
      then
         return 10;
         
      elsif
        Produktion < WichtigesKonstanten.LeerGeldZugewinnProRunde
        and
          StadtKonstanten.LeerGeldgewinnung = Produktionsbonus
      then
         return 5;
         
      elsif
        WichtigesKonstanten.LeerGeldZugewinnProRunde >= Produktion - PermanenteKosten
      then
         return -20;
         
      else
         return KIDatentypen.BauenBewertung (Produktionsbonus - PermanenteKosten);
      end if;
      
   end GeldproduktionBewerten;
   
   
     
   function WissensgewinnBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return KIDatentypen.BauenBewertung
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      Produktion := LeseStadtGebaut.Forschungsrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      Produktionsbonus := LeseGebaeudeDatenbank.Produktionsbonus (SpeziesExtern          => StadtSpeziesNummerExtern.Spezies,
                                                                  IDExtern               => IDExtern,
                                                                  ProduktionsbonusExtern => ProduktionDatentypen.Forschung_Enum);
      
      if
        Produktion = StadtKonstanten.LeerForschungsrate
        and
          Produktionsbonus > WichtigesKonstanten.LeerGesamteForschungsrate
      then
         return 5;
         
      else
         return KIDatentypen.BauenBewertung (Produktionsbonus);
      end if;
      
   end WissensgewinnBewerten;
   
     
          
   function MaterialproduktionBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return KIDatentypen.BauenBewertung
   is
      use type ProduktionDatentypen.Produktion;
      use type KIDatentypen.BauenBewertung;
   begin
      
      Produktion := LeseStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      Produktionsbonus := LeseGebaeudeDatenbank.Produktionsbonus (SpeziesExtern          => StadtSpeziesNummerExtern.Spezies,
                                                                  IDExtern               => IDExtern,
                                                                  ProduktionsbonusExtern => ProduktionDatentypen.Material_Enum);
      PermanenteKosten := LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                  IDExtern           => IDExtern,
                                                                  WelcheKostenExtern => ProduktionDatentypen.Material_Enum);
      
      if
        Produktion < StadtKonstanten.LeerProduktionrate
        and
          StadtKonstanten.LeerProduktionrate < Produktion + Produktionsbonus
      then
         return 20;
         
      elsif
        Produktion < StadtKonstanten.LeerProduktionrate
        and
          StadtKonstanten.LeerProduktionrate <= Produktion + Produktionsbonus
      then
         return 10;
         
      elsif
        Produktion < StadtKonstanten.LeerProduktionrate
        and
          StadtKonstanten.LeerProduktionrate = Produktion + Produktionsbonus
      then
         return 5;
         
      elsif
        StadtKonstanten.LeerProduktionrate >= Produktion - PermanenteKosten
      then
         return -20;
         
      else
         return KIDatentypen.BauenBewertung (Produktionsbonus - PermanenteKosten);
      end if;
      
   end MaterialproduktionBewerten;
     
   
     
   function VerteidigungBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
   begin
      
      case
        KIKriegErmittelnLogik.IstImKrieg (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
      is
         when True =>
            return 2 * KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => StadtSpeziesNummerExtern.Spezies,
                                                                                      IDExtern         => IDExtern,
                                                                                      KampfBonusExtern => KampfDatentypen.Verteidigung_Enum));
            
         when False =>
            return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => StadtSpeziesNummerExtern.Spezies,
                                                                                  IDExtern         => IDExtern,
                                                                                  KampfBonusExtern => KampfDatentypen.Verteidigung_Enum));
      end case;
      
   end VerteidigungBewerten;
     
   
     
   function AngriffBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
   begin
      
      case
        KIKriegErmittelnLogik.IstImKrieg (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
      is
         when True =>
            return 2 * KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => StadtSpeziesNummerExtern.Spezies,
                                                                                      IDExtern         => IDExtern,
                                                                                      KampfBonusExtern => KampfDatentypen.Angriff_Enum));
            
         when False =>
            return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => StadtSpeziesNummerExtern.Spezies,
                                                                                  IDExtern         => IDExtern,
                                                                                  KampfBonusExtern => KampfDatentypen.Angriff_Enum));
      end case;
      
   end AngriffBewerten;
     
   
     
   function KostenBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
      use type ProduktionDatentypen.Produktion;
   begin
      
      return -(KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.Produktionskosten (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                     IDExtern      => IDExtern)
               / LeseStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
               / 10));
      
   end KostenBewerten;

end KIGebaeudeBauenLogik;

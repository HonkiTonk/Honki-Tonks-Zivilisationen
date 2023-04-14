with WichtigesKonstanten;
with KartenKonstanten;
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
      use type StadtDatentypen.GebäudeIDMitNullwert;
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
      IDExtern : in StadtDatentypen.GebäudeID)
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
      Gesamtwertung := Gesamtwertung + RessourcenproduktionBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                     IDExtern                 => IDExtern);
      Gesamtwertung := Gesamtwertung + VerteidigungBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                             IDExtern                 => IDExtern);
      Gesamtwertung := Gesamtwertung + AngriffBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                        IDExtern                 => IDExtern);
      Gesamtwertung := Gesamtwertung + KostenBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                       IDExtern                 => IDExtern);
      
      return Gesamtwertung;
            
   end GebäudeBewerten;
   
   
   
   -- Mal die Abfragen in ein lokale Variable schieben. äöü
   function NahrungsproduktionBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is
      use type ProduktionDatentypen.Produktion;
      use type KIDatentypen.BauenBewertung;
   begin
      
      Produktion := LeseStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      if
        Produktion < StadtKonstanten.LeerNahrungsproduktion
        and
          StadtKonstanten.LeerNahrungsproduktion < Produktion + LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => StadtSpeziesNummerExtern.Spezies,
                                                                                                       IDExtern              => IDExtern,
                                                                                                       WirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
      then
         return 20;
         
      elsif
        Produktion < StadtKonstanten.LeerNahrungsproduktion
        and
          LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => StadtSpeziesNummerExtern.Spezies,
                                                 IDExtern              => IDExtern,
                                                 WirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
        > StadtKonstanten.LeerNahrungsproduktion
      then
         return 10;
         
      elsif
        Produktion < StadtKonstanten.LeerNahrungsproduktion
        and
          StadtKonstanten.LeerNahrungsproduktion = LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => StadtSpeziesNummerExtern.Spezies,
                                                                                          IDExtern              => IDExtern,
                                                                                          WirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
      then
         return 5;
      
      elsif
        StadtKonstanten.LeerNahrungsproduktion >= Produktion - LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                                                       IDExtern           => IDExtern,
                                                                                                       WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)
      then
         return -20;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => StadtSpeziesNummerExtern.Spezies,
                                                                                    IDExtern              => IDExtern,
                                                                                    WirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
                                             - LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                                       IDExtern           => IDExtern,
                                                                                       WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum));
      end if;
      
   end NahrungsproduktionBewerten;
   
   
   
   function GeldproduktionBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is
      use type ProduktionDatentypen.Produktion;
      use type KIDatentypen.BauenBewertung;
   begin
      
      Produktion := LeseWichtiges.GeldZugewinnProRunde (SpeziesExtern => StadtSpeziesNummerExtern.Spezies);
      
      if
        Produktion < WichtigesKonstanten.LeerGeldZugewinnProRunde
        and
          WichtigesKonstanten.LeerGeldZugewinnProRunde < Produktion + LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => StadtSpeziesNummerExtern.Spezies,
                                                                                                             IDExtern              => IDExtern,
                                                                                                             WirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
      then
         return 20;
         
      elsif
        Produktion < WichtigesKonstanten.LeerGeldZugewinnProRunde
        and
          LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => StadtSpeziesNummerExtern.Spezies,
                                                 IDExtern              => IDExtern,
                                                 WirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
        > StadtKonstanten.LeerGeldgewinnung
      then
         return 10;
         
      elsif
        Produktion < WichtigesKonstanten.LeerGeldZugewinnProRunde
        and
          StadtKonstanten.LeerGeldgewinnung = LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => StadtSpeziesNummerExtern.Spezies,
                                                                                     IDExtern              => IDExtern,
                                                                                     WirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
      then
         return 5;
         
      elsif
        WichtigesKonstanten.LeerGeldZugewinnProRunde >= Produktion - LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                                                             IDExtern           => IDExtern,
                                                                                                             WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)
      then
         return -20;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => StadtSpeziesNummerExtern.Spezies,
                                                                                    IDExtern              => IDExtern,
                                                                                    WirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
                                             - LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                                       IDExtern           => IDExtern,
                                                                                       WelcheKostenExtern => ProduktionDatentypen.Geld_Enum));
      end if;
      
   end GeldproduktionBewerten;
   
   
     
   function WissensgewinnBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      Produktion := LeseStadtGebaut.Forschungsrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      if
        Produktion = StadtKonstanten.LeerForschungsrate
        and
          LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => StadtSpeziesNummerExtern.Spezies,
                                                 IDExtern              => IDExtern,
                                                 WirtschaftBonusExtern => KartenKonstanten.WirtschaftForschung)
        > WichtigesKonstanten.LeerGesamteForschungsrate
      then
         return 5;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => StadtSpeziesNummerExtern.Spezies,
                                                                                    IDExtern              => IDExtern,
                                                                                    WirtschaftBonusExtern => KartenKonstanten.WirtschaftForschung));
      end if;
      
   end WissensgewinnBewerten;
   
     
          
   function RessourcenproduktionBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is
      use type ProduktionDatentypen.Produktion;
      use type KIDatentypen.BauenBewertung;
   begin
      
      Produktion := LeseStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      if
        Produktion < StadtKonstanten.LeerProduktionrate
        and
          StadtKonstanten.LeerProduktionrate < Produktion + LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => StadtSpeziesNummerExtern.Spezies,
                                                                                                   IDExtern              => IDExtern,
                                                                                                   WirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
      then
         return 20;
         
      elsif
        Produktion < StadtKonstanten.LeerProduktionrate
        and
          StadtKonstanten.LeerProduktionrate <= Produktion + LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => StadtSpeziesNummerExtern.Spezies,
                                                                                                    IDExtern              => IDExtern,
                                                                                                    WirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
      then
         return 10;
         
      elsif
        Produktion < StadtKonstanten.LeerProduktionrate
        and
          StadtKonstanten.LeerProduktionrate = Produktion + LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => StadtSpeziesNummerExtern.Spezies,
                                                                                                   IDExtern              => IDExtern,
                                                                                                   WirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
      then
         return 5;
         
      elsif
        StadtKonstanten.LeerProduktionrate >= Produktion - LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                                                   IDExtern           => IDExtern,
                                                                                                   WelcheKostenExtern => ProduktionDatentypen.Produktion_Enum)
      then
         return -20;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => StadtSpeziesNummerExtern.Spezies,
                                                                                    IDExtern              => IDExtern,
                                                                                    WirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
                                             - LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                                       IDExtern           => IDExtern,
                                                                                       WelcheKostenExtern => ProduktionDatentypen.Produktion_Enum));
      end if;
      
   end RessourcenproduktionBewerten;
     
   
     
   function VerteidigungBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
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
                                                                                      KampfBonusExtern => KartenKonstanten.KampfVerteidigung));
            
         when False =>
            return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => StadtSpeziesNummerExtern.Spezies,
                                                                                  IDExtern         => IDExtern,
                                                                                  KampfBonusExtern => KartenKonstanten.KampfVerteidigung));
      end case;
      
   end VerteidigungBewerten;
     
   
     
   function AngriffBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
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
                                                                                      KampfBonusExtern => KartenKonstanten.KampfAngriff));
            
         when False =>
            return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => StadtSpeziesNummerExtern.Spezies,
                                                                                  IDExtern         => IDExtern,
                                                                                  KampfBonusExtern => KartenKonstanten.KampfAngriff));
      end case;
      
   end AngriffBewerten;
     
   
     
   function KostenBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
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

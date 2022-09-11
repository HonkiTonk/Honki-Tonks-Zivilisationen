pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen; use ProduktionDatentypen;
with StadtDatentypen; use StadtDatentypen;
with WichtigesKonstanten;
with StadtKonstanten;
with KartenKonstanten;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with LeseGebaeudeDatenbank;
with LeseStadtGebaut;
with LeseWichtiges;

with GebaeudeAllgemeinLogik;
with KIKriegErmitteln;

package body KIGebaeudeBauen is

   function GebäudeBauen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KIRecords.GebäudeIDBewertungRecord
   is begin
      
      GebäudeBewertet := KIKonstanten.LeerGebäudeIDBewertung;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtRecords.GebäudeVorhandenArray'Range loop
         
         case
           GebaeudeAllgemeinLogik.GebäudeAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                 IDExtern               => GebäudeSchleifenwert)
         is
            when True =>
               Gebäudewertung := GebäudeBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                    IDExtern               => GebäudeSchleifenwert);
                     
               if
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
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is begin
      
      Gesamtwertung := 0;
      
      Gesamtwertung := Gesamtwertung + NahrungsproduktionBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                   IDExtern               => IDExtern);
      Gesamtwertung := Gesamtwertung + GeldproduktionBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               IDExtern               => IDExtern);
      Gesamtwertung := Gesamtwertung + WissensgewinnBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                              IDExtern               => IDExtern);
      Gesamtwertung := Gesamtwertung + RessourcenproduktionBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                     IDExtern               => IDExtern);
      Gesamtwertung := Gesamtwertung + VerteidigungBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             IDExtern               => IDExtern);
      Gesamtwertung := Gesamtwertung + AngriffBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                        IDExtern               => IDExtern);
      Gesamtwertung := Gesamtwertung + KostenBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                       IDExtern               => IDExtern);
      
      return Gesamtwertung;
            
   end GebäudeBewerten;
   
   
   
   -- Mal die Abfragen in ein lokale Variable schieben. äöü
   function NahrungsproduktionBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is begin
      
      if
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerNahrungsproduktion
        and
          LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern)
        + LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WWirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
        >= StadtKonstanten.LeerNahrungsproduktion
      then
         return 20;
                  
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerNahrungsproduktion
        and
          LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WWirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
        > StadtKonstanten.LeerNahrungsproduktion
      then
         return 10;
         
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerNahrungsproduktion
        and
          LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WWirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
        = StadtKonstanten.LeerNahrungsproduktion
      then
         return 5;
      
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern)
        - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)
        < StadtKonstanten.LeerNahrungsproduktion
      then
         return -20;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                                                    IDExtern               => IDExtern,
                                                                                    WWirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
                                             - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                       IDExtern           => IDExtern,
                                                                                       WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum));
      end if;
      
   end NahrungsproduktionBewerten;
   
   
   
   function GeldproduktionBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is begin
      
      if
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse) < WichtigesKonstanten.LeerGeldZugewinnProRunde
        and
          LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse)
        + LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WWirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
        >= WichtigesKonstanten.LeerGeldZugewinnProRunde
      then
         return 20;
         
      elsif
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse) < WichtigesKonstanten.LeerGeldZugewinnProRunde
        and
          LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WWirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
        > StadtKonstanten.LeerGeldgewinnung
      then
         return 10;
         
      elsif
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse) < WichtigesKonstanten.LeerGeldZugewinnProRunde
        and
          StadtKonstanten.LeerGeldgewinnung = LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                                                     IDExtern               => IDExtern,
                                                                                     WWirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
      then
         return 5;
         
      elsif
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse)
        - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)
        < WichtigesKonstanten.LeerGeldZugewinnProRunde
      then
         return -20;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                                                    IDExtern               => IDExtern,
                                                                                    WWirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
                                             - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                       IDExtern           => IDExtern,
                                                                                       WelcheKostenExtern => ProduktionDatentypen.Geld_Enum));
      end if;
      
   end GeldproduktionBewerten;
   
   
     
   function WissensgewinnBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is begin
      
      if
        LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern) = StadtKonstanten.LeerForschungsrate
        and
          LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WWirtschaftBonusExtern => KartenKonstanten.WirtschaftForschung)
        > WichtigesKonstanten.LeerGesamteForschungsrate
      then
         return 5;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                                                    IDExtern               => IDExtern,
                                                                                    WWirtschaftBonusExtern => KartenKonstanten.WirtschaftForschung));
      end if;
      
   end WissensgewinnBewerten;
   
     
          
   function RessourcenproduktionBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is begin
      
      if
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerProduktionrate
        and
          LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
        + LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WWirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
        >= StadtKonstanten.LeerProduktionrate
      then
         return 20;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerProduktionrate
        and
          LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
          + LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                   IDExtern               => IDExtern,
                                                   WWirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
        > StadtKonstanten.LeerProduktionrate
      then
         return 10;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerProduktionrate
        and
          LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
          + LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                   IDExtern               => IDExtern,
                                                   WWirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
        = StadtKonstanten.LeerProduktionrate
      then
         return 5;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
        - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcheKostenExtern => ProduktionDatentypen.Ressourcen_Enum)
        < StadtKonstanten.LeerProduktionrate
      then
         return -20;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                                                    IDExtern               => IDExtern,
                                                                                    WWirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
                                             - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                       IDExtern           => IDExtern,
                                                                                       WelcheKostenExtern => ProduktionDatentypen.Ressourcen_Enum));
      end if;
      
   end RessourcenproduktionBewerten;
     
   
     
   function VerteidigungBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is begin
      
      case
        KIKriegErmitteln.IstImKrieg (RasseExtern => StadtRasseNummerExtern.Rasse)
      is
         when True =>
            return 2 * KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                                      IDExtern         => IDExtern,
                                                                                      KampfBonusExtern => KartenKonstanten.KampfVerteidigung));
            
         when False =>
            return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                                  IDExtern         => IDExtern,
                                                                                  KampfBonusExtern => KartenKonstanten.KampfVerteidigung));
      end case;
      
   end VerteidigungBewerten;
     
   
     
   function AngriffBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is begin
      
      case
        KIKriegErmitteln.IstImKrieg (RasseExtern => StadtRasseNummerExtern.Rasse)
      is
         when True =>
            return 2 * KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                                      IDExtern         => IDExtern,
                                                                                      KampfBonusExtern => KartenKonstanten.KampfAngriff));
            
         when False =>
            return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                                  IDExtern         => IDExtern,
                                                                                  KampfBonusExtern => KartenKonstanten.KampfAngriff));
      end case;
      
   end AngriffBewerten;
     
   
     
   function KostenBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is begin
      
      return -(KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                   IDExtern    => IDExtern)
               / LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
               / 10));
      
   end KostenBewerten;

end KIGebaeudeBauen;

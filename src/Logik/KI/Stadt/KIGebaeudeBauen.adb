pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with SonstigesKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with KartenKonstanten;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with LeseGebaeudeDatenbank;
with LeseStadtGebaut;
with LeseWichtiges;

with GebaeudeAllgemein;

package body KIGebaeudeBauen is

   function GebäudeBauen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KIRecords.GebäudeIDBewertungRecord
   is begin
      
      GebäudeBewertet := KIKonstanten.LeerGebäudeIDBewertung;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in EinheitStadtRecords.GebäudeVorhandenArray'Range loop
         
         case
           GebaeudeAllgemein.GebäudeAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                            IDExtern               => GebäudeSchleifenwert)
         is
            when True =>
               GebäudeBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                 IDExtern               => GebäudeSchleifenwert);
               
            when False =>
               null;
         end case;
         
      end loop GebäudeSchleife;
      
      return GebäudeBewertet;
      
   end GebäudeBauen;
   
   
   
   procedure GebäudeBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
   is begin
      
      Gesamtwertung := KIDatentypen.BauenBewertung (EinheitStadtDatentypen.GebäudeID'Last - IDExtern);
      
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
      
      if
        GebäudeBewertet.ID = EinheitenKonstanten.LeerID
        or
          GebäudeBewertet.Bewertung < Gesamtwertung
      then
         GebäudeBewertet := (IDExtern, Gesamtwertung);

      else
         null;
      end if;
            
   end GebäudeBewerten;
   
   
   
   function NahrungsproduktionBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is begin
      
      if
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerStadt.Nahrungsproduktion
        and
          LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern)
        + LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WWirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
        >= StadtKonstanten.LeerStadt.Nahrungsproduktion
      then
         return 20;
                  
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerStadt.Nahrungsproduktion
        and
          LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WWirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
        > StadtKonstanten.LeerStadt.Nahrungsproduktion
      then
         return 10;
         
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerStadt.Nahrungsproduktion
        and
          LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WWirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
        = StadtKonstanten.LeerStadt.Nahrungsproduktion
      then
         return 5;
      
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern)
        - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcheKostenExtern => EinheitStadtDatentypen.Nahrung_Enum)
        < StadtKonstanten.LeerStadt.Nahrungsproduktion
      then
         return -20;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                                                    IDExtern               => IDExtern,
                                                                                    WWirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
                                             - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                       IDExtern           => IDExtern,
                                                                                       WelcheKostenExtern => EinheitStadtDatentypen.Nahrung_Enum));
      end if;
      
   end NahrungsproduktionBewerten;
   
   
   
   function GeldproduktionBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is begin
      
      if
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse) < SonstigesKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
        and
          LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse)
        + LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WWirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
        >= SonstigesKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
      then
         return 20;
         
      elsif
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse) < SonstigesKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
        and
          LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WWirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
        > StadtKonstanten.LeerStadt.Geldgewinnung
      then
         return 10;
         
      elsif
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse) < SonstigesKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
        and
          LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WWirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
        = StadtKonstanten.LeerStadt.Geldgewinnung
      then
         return 5;
         
      elsif
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse)
        - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcheKostenExtern => EinheitStadtDatentypen.Geld_Enum)
        < SonstigesKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
      then
         return -20;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                                                    IDExtern               => IDExtern,
                                                                                    WWirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
                                             - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                       IDExtern           => IDExtern,
                                                                                       WelcheKostenExtern => EinheitStadtDatentypen.Geld_Enum));
      end if;
      
   end GeldproduktionBewerten;
   
   
     
   function WissensgewinnBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is begin
      
      if
        LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern) = StadtKonstanten.LeerStadt.Forschungsrate
        and
          LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WWirtschaftBonusExtern => KartenKonstanten.WirtschaftForschung)
        > SonstigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate
      then
         return 5;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                                                    IDExtern               => IDExtern,
                                                                                    WWirtschaftBonusExtern => KartenKonstanten.WirtschaftForschung));
      end if;
      
   end WissensgewinnBewerten;
   
     
          
   function RessourcenproduktionBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is begin
      
      if
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerStadt.Produktionrate
        and
          LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
        + LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WWirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
        >= StadtKonstanten.LeerStadt.Produktionrate
      then
         return 20;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerStadt.Produktionrate
        and
          + LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                   IDExtern               => IDExtern,
                                                   WWirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
        > StadtKonstanten.LeerStadt.Produktionrate
      then
         return 10;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerStadt.Produktionrate
        and
          + LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                   IDExtern               => IDExtern,
                                                   WWirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
        = StadtKonstanten.LeerStadt.Produktionrate
      then
         return 5;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
        - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcheKostenExtern => EinheitStadtDatentypen.Ressourcen_Enum)
        < StadtKonstanten.LeerStadt.Produktionrate
      then
         return -20;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                                                    IDExtern               => IDExtern,
                                                                                    WWirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
                                             - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                       IDExtern           => IDExtern,
                                                                                       WelcheKostenExtern => EinheitStadtDatentypen.Ressourcen_Enum));
      end if;
      
   end RessourcenproduktionBewerten;
     
   
     
   function VerteidigungBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is begin
      
      return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                            IDExtern         => IDExtern,
                                                                            KampfBonusExtern => KartenKonstanten.KampfVerteidigung));
      
   end VerteidigungBewerten;
     
   
     
   function AngriffBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is begin
      
      return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                            IDExtern         => IDExtern,
                                                                            KampfBonusExtern => KartenKonstanten.KampfAngriff));
      
   end AngriffBewerten;
     
   
     
   function KostenBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is begin
      
      return -(KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                   IDExtern    => IDExtern)
               / LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
               / 10));
      
   end KostenBewerten;

end KIGebaeudeBauen;

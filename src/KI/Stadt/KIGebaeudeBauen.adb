pragma SPARK_Mode (On);

with SonstigesKonstanten, EinheitenKonstanten, StadtKonstanten, EinheitStadtDatentypen, KartenDatentypen;
use EinheitStadtDatentypen;

with KIKonstanten;

with LeseGebaeudeDatenbank, LeseStadtGebaut, LeseWichtiges;

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
      
      Gesamtwertung := EinheitStadtDatentypen.KostenLager (EinheitStadtDatentypen.GebäudeID'Last - IDExtern);
      
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
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      if
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerStadt.Nahrungsproduktion
        and
          LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern)
        + LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcherBonusExtern => KartenDatentypen.Nahrung)
        >= StadtKonstanten.LeerStadt.Nahrungsproduktion
      then
         return 20;
                  
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerStadt.Nahrungsproduktion
        and
          LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcherBonusExtern => KartenDatentypen.Nahrung)
        > StadtKonstanten.LeerStadt.Nahrungsproduktion
      then
         return 10;
         
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerStadt.Nahrungsproduktion
        and
          LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcherBonusExtern => KartenDatentypen.Nahrung)
        = StadtKonstanten.LeerStadt.Nahrungsproduktion
      then
         return 5;
      
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern)
        - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcheKostenExtern => EinheitStadtDatentypen.Nahrung)
        < StadtKonstanten.LeerStadt.Nahrungsproduktion
      then
         return -20;
         
      else
         return LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                        IDExtern           => IDExtern,
                                                        WelcherBonusExtern => KartenDatentypen.Nahrung)
           - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                     IDExtern           => IDExtern,
                                                     WelcheKostenExtern => EinheitStadtDatentypen.Nahrung);
      end if;
      
   end NahrungsproduktionBewerten;
   
   
   
   function GeldproduktionBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      if
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse) < SonstigesKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
        and
          LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse)
        + LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcherBonusExtern => KartenDatentypen.Geld)
        >= SonstigesKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
      then
         return 20;
         
      elsif
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse) < SonstigesKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
        and
          LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcherBonusExtern => KartenDatentypen.Geld)
        > StadtKonstanten.LeerStadt.Geldgewinnung
      then
         return 10;
         
      elsif
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse) < SonstigesKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
        and
          LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcherBonusExtern => KartenDatentypen.Geld)
        = StadtKonstanten.LeerStadt.Geldgewinnung
      then
         return 5;
         
      elsif
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse)
        - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcheKostenExtern => EinheitStadtDatentypen.Geld)
        < SonstigesKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
      then
         return -20;
         
      else
         return LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                        IDExtern           => IDExtern,
                                                        WelcherBonusExtern => KartenDatentypen.Geld)
           - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                     IDExtern           => IDExtern,
                                                     WelcheKostenExtern => EinheitStadtDatentypen.Geld);
      end if;
      
   end GeldproduktionBewerten;
   
   
     
   function WissensgewinnBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      if
        LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern) = StadtKonstanten.LeerStadt.Forschungsrate
        and
          LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcherBonusExtern => KartenDatentypen.Wissen)
        > SonstigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate
      then
         return 5;
         
      else
         return LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                        IDExtern           => IDExtern,
                                                        WelcherBonusExtern => KartenDatentypen.Wissen);
      end if;
      
   end WissensgewinnBewerten;
   
     
          
   function RessourcenproduktionBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      if
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerStadt.Produktionrate
        and
          LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
        + LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcherBonusExtern => KartenDatentypen.Produktion)
        >= StadtKonstanten.LeerStadt.Produktionrate
      then
         return 20;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerStadt.Produktionrate
        and
          + LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                    IDExtern           => IDExtern,
                                                    WelcherBonusExtern => KartenDatentypen.Produktion)
        > StadtKonstanten.LeerStadt.Produktionrate
      then
         return 10;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerStadt.Produktionrate
        and
          + LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                    IDExtern           => IDExtern,
                                                    WelcherBonusExtern => KartenDatentypen.Produktion)
        = StadtKonstanten.LeerStadt.Produktionrate
      then
         return 5;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
        - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcheKostenExtern => EinheitStadtDatentypen.Ressourcen)
        < StadtKonstanten.LeerStadt.Produktionrate
      then
         return -20;
         
      else
         return LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                        IDExtern           => IDExtern,
                                                        WelcherBonusExtern => KartenDatentypen.Produktion)
           - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                     IDExtern           => IDExtern,
                                                     WelcheKostenExtern => EinheitStadtDatentypen.Ressourcen);
      end if;
      
   end RessourcenproduktionBewerten;
     
   
     
   function VerteidigungBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      return LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                     IDExtern           => IDExtern,
                                                     WelcherBonusExtern => KartenDatentypen.Verteidigung);
      
   end VerteidigungBewerten;
     
   
     
   function AngriffBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      return LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                     IDExtern           => IDExtern,
                                                     WelcherBonusExtern => KartenDatentypen.Angriff);
      
   end AngriffBewerten;
     
   
     
   function KostenBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      return -(LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                      IDExtern    => IDExtern)
               / LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
               / 10);
      
   end KostenBewerten;

end KIGebaeudeBauen;

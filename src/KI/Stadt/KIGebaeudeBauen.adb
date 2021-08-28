pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIKonstanten;

with LeseGebaeudeDatenbank, LeseStadtGebaut, LeseWichtiges;

with GebaeudeAllgemein;

package body KIGebaeudeBauen is

   function GebäudeBauen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIRecords.GebäudeIDBewertungRecord
   is begin
      
      GebäudeBewertet := KIKonstanten.LeerGebäudeIDBewertung;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in GlobaleRecords.GebäudeVorhandenArray'Range loop
         
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
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.GebäudeID)
   is begin
      
      Gesamtwertung := GlobaleDatentypen.KostenLager (GlobaleDatentypen.GebäudeID'Last - IDExtern);
      
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
        GebäudeBewertet.ID = GlobaleKonstanten.LeerEinheitenID
        or
          GebäudeBewertet.Bewertung < Gesamtwertung
      then
         GebäudeBewertet := (IDExtern, Gesamtwertung);

      else
         null;
      end if;
            
   end GebäudeBewerten;
   
   
   
   function NahrungsproduktionBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      if
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) < GlobaleKonstanten.LeerStadt.Nahrungsproduktion
        and
          LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern)
        + LeseGebaeudeDatenbank.NahrungBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                              IDExtern    => IDExtern)
        >= GlobaleKonstanten.LeerStadt.Nahrungsproduktion
      then
         return 20;
                  
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) < GlobaleKonstanten.LeerStadt.Nahrungsproduktion
        and
          LeseGebaeudeDatenbank.NahrungBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                              IDExtern    => IDExtern)
        > GlobaleKonstanten.LeerStadt.Nahrungsproduktion
      then
         return 10;
         
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) < GlobaleKonstanten.LeerStadt.Nahrungsproduktion
        and
          LeseGebaeudeDatenbank.NahrungBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                              IDExtern    => IDExtern)
        = GlobaleKonstanten.LeerStadt.Nahrungsproduktion
      then
         return 5;
      
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern)
        - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcheKostenExtern => GlobaleDatentypen.Nahrung)
        < GlobaleKonstanten.LeerStadt.Nahrungsproduktion
      then
         return -20;
         
      else
         return LeseGebaeudeDatenbank.NahrungBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                    IDExtern    => IDExtern)
           - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                     IDExtern           => IDExtern,
                                                     WelcheKostenExtern => GlobaleDatentypen.Nahrung);
      end if;
      
   end NahrungsproduktionBewerten;
   
   
   
   function GeldproduktionBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      if
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse) < GlobaleKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
        and
          LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse)
        + LeseGebaeudeDatenbank.GeldBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                           IDExtern    => IDExtern)
        >= GlobaleKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
      then
         return 20;
         
      elsif
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse) < GlobaleKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
        and
          LeseGebaeudeDatenbank.GeldBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                           IDExtern    => IDExtern)
        > GlobaleKonstanten.LeerStadt.Geldgewinnung
      then
         return 10;
         
      elsif
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse) < GlobaleKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
        and
          LeseGebaeudeDatenbank.GeldBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                           IDExtern    => IDExtern)
        = GlobaleKonstanten.LeerStadt.Geldgewinnung
      then
         return 5;
         
      elsif
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse)
        - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcheKostenExtern => GlobaleDatentypen.Geld)
        < GlobaleKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
      then
         return -20;
         
      else
         return LeseGebaeudeDatenbank.GeldBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                 IDExtern    => IDExtern)
           - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                     IDExtern           => IDExtern,
                                                     WelcheKostenExtern => GlobaleDatentypen.Geld);
      end if;
      
   end GeldproduktionBewerten;
   
   
     
   function WissensgewinnBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      if
        LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern) = GlobaleKonstanten.LeerStadt.Forschungsrate
        and
          LeseGebaeudeDatenbank.WissenBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                             IDExtern    => IDExtern)
        > GlobaleKonstanten.LeerWichtigesZeug.GesamteForschungsrate
      then
         return 5;
         
      else
         return LeseGebaeudeDatenbank.WissenBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                   IDExtern    => IDExtern);
      end if;
      
   end WissensgewinnBewerten;
   
     
          
   function RessourcenproduktionBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      if
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) < GlobaleKonstanten.LeerStadt.Produktionrate
        and
          LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
        + LeseGebaeudeDatenbank.ProduktionBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                 IDExtern    => IDExtern)
        >= GlobaleKonstanten.LeerStadt.Produktionrate
      then
         return 20;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) < GlobaleKonstanten.LeerStadt.Produktionrate
        and
          + LeseGebaeudeDatenbank.ProduktionBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                   IDExtern    => IDExtern)
        > GlobaleKonstanten.LeerStadt.Produktionrate
      then
         return 10;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) < GlobaleKonstanten.LeerStadt.Produktionrate
        and
          + LeseGebaeudeDatenbank.ProduktionBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                   IDExtern    => IDExtern)
        = GlobaleKonstanten.LeerStadt.Produktionrate
      then
         return 5;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
        - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                  IDExtern           => IDExtern,
                                                  WelcheKostenExtern => GlobaleDatentypen.Ressourcen)
        < GlobaleKonstanten.LeerStadt.Produktionrate
      then
         return -20;
         
      else
         return LeseGebaeudeDatenbank.ProduktionBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                       IDExtern    => IDExtern)
           - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                     IDExtern           => IDExtern,
                                                     WelcheKostenExtern => GlobaleDatentypen.Ressourcen);
      end if;
      
   end RessourcenproduktionBewerten;
     
   
     
   function VerteidigungBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return LeseGebaeudeDatenbank.VerteidigungBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                      IDExtern    => IDExtern);
      
   end VerteidigungBewerten;
     
   
     
   function AngriffBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return LeseGebaeudeDatenbank.AngriffBonus (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                 IDExtern    => IDExtern);
      
   end AngriffBewerten;
     
   
     
   function KostenBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return -(LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                      IDExtern    => IDExtern)
               / LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
               / 10);
      
   end KostenBewerten;

end KIGebaeudeBauen;

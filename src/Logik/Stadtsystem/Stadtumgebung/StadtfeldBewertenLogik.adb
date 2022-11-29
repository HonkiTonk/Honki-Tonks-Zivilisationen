with LeseStadtGebaut;

with KartenfelderwerteLogik;

package body StadtfeldBewertenLogik is

   function FeldBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenEntfernenExtern : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      return NahrungBewertung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                               KoordinatenExtern      => KoordinatenExtern,
                               BelegenEntfernenExtern   => BelegenEntfernenExtern)
        + ProduktionBewertung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                               KoordinatenExtern      => KoordinatenExtern,
                               BelegenEntfernenExtern   => BelegenEntfernenExtern)
        + GeldBewertung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                         KoordinatenExtern      => KoordinatenExtern,
                         BelegenEntfernenExtern   => BelegenEntfernenExtern)
        + WissenBewertung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                           KoordinatenExtern      => KoordinatenExtern,
                           BelegenEntfernenExtern   => BelegenEntfernenExtern);
      
   end FeldBewerten;
   
   
   
   function NahrungBewertung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenEntfernenExtern : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      NahrungGesamt := KartenfelderwerteLogik.FeldNahrung (KoordinatenExtern => KoordinatenExtern,
                                                           RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      if
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) <= 1
        and
          NahrungGesamt >= 1
      then
         case
           BelegenEntfernenExtern
         is
            when True =>
               return 100 + (NahrungGesamt * 50);
               
            when False =>
               return -100 - (NahrungGesamt * 50);
         end case;
         
      else
         case
           BelegenEntfernenExtern
         is
            when True =>
               return NahrungGesamt;
               
            when False =>
               return -NahrungGesamt;
         end case;
      end if;
      
   end NahrungBewertung;
   
   
   
   function ProduktionBewertung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenEntfernenExtern : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      RessourcenGesamt := KartenfelderwerteLogik.FeldProduktion (KoordinatenExtern => KoordinatenExtern,
                                                                 RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      if
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) <= 0
        and
          RessourcenGesamt >= 1
      then
         case
           BelegenEntfernenExtern
         is
            when True =>
               return 25 + RessourcenGesamt;
               
            when False =>
               return -25 - RessourcenGesamt;
         end case;
         
      else
         case
           BelegenEntfernenExtern
         is
            when True =>
               return RessourcenGesamt;
               
            when False =>
               return -RessourcenGesamt;
         end case;
      end if;
      
   end ProduktionBewertung;



   function GeldBewertung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenEntfernenExtern : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      GeldGesamt := KartenfelderwerteLogik.FeldGeld (KoordinatenExtern => KoordinatenExtern,
                                                     RasseExtern       => StadtRasseNummerExtern.Rasse);

      if
        LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern) <= 0
        and
          GeldGesamt >= 1
      then
         case
           BelegenEntfernenExtern
         is
            when True =>
               return 25 + GeldGesamt;
               
            when False =>
               return -25 - GeldGesamt;
         end case;
         
      else
         case
           BelegenEntfernenExtern
         is
            when True =>
               return GeldGesamt;
               
            when False =>
               return -GeldGesamt;
         end case;
      end if;

   end GeldBewertung;
   
   
   
   function WissenBewertung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenEntfernenExtern : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin

      WissenGesamt := KartenfelderwerteLogik.FeldWissen (KoordinatenExtern => KoordinatenExtern,
                                                         RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      if
        LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern) = 0
        and
          WissenGesamt >= 1
      then
         case
           BelegenEntfernenExtern
         is
            when True =>
               return 25 + WissenGesamt;
               
            when False =>
               return -25 - WissenGesamt;
         end case;
      
      else
         case
           BelegenEntfernenExtern
         is
            when True =>
               return WissenGesamt;
               
            when False =>
               return -WissenGesamt;
         end case;
      end if;
      
   end WissenBewertung;

end StadtfeldBewertenLogik;

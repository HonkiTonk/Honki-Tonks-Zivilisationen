pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;
with SystemDatentypen;
with StadtDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;

with StadtEntfernenLogik;
with KampfwerteStadtErmittelnLogik;
with KampfwerteEinheitErmittelnLogik;
with StadtwerteFestlegenLogik;
with MeldungenSetzenLogik;
with EinheitenErzeugenEntfernenLogik;
with KampfberechnungenLogik;

package body KampfsystemStadtLogik is

   function KampfsystemStadt
     (AngreifendeEinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      VerteidigendeStadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      KampfwerteVerteidiger.Verteidigung := KampfwerteStadtErmittelnLogik.AktuelleVerteidigungStadt (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
      KampfwerteVerteidiger.Angriff := KampfwerteStadtErmittelnLogik.AktuellerAngriffStadt (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
      
      KampfwerteAngreifer.Verteidigung := KampfwerteEinheitErmittelnLogik.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                                                                                                       AngreiferExtern          => True);
      KampfwerteAngreifer.Angriff := KampfwerteEinheitErmittelnLogik.AktuellerAngriffEinheit (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                                                                                              AngreiferExtern          => True);
      
      return Kampf (AngreifendeEinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                    KampfwerteAngreiferExtern           => KampfwerteAngreifer,
                    VerteidigendeStadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern,
                    KampfwerteVerteidigerExtern         => KampfwerteVerteidiger);
      
   end KampfsystemStadt;
   
   
   
   function Kampf
     (AngreifendeEinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord;
      VerteidigendeStadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
   is begin
      
      case
        Kampfverlauf (AngreifendeEinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                      KampfwerteAngreiferExtern           => KampfwerteAngreiferExtern,
                      VerteidigendeStadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern,
                      KampfwerteVerteidigerExtern         => KampfwerteVerteidigerExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      -- Kann man das teilweise mit der Personenänderung im Stadtsystem zusammenführen? äöü
      -- Scheinbar nicht, wenn dann müsste man eines der beiden Systeme anpassen. äöü
      if
        LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => VerteidigendeStadtRasseNummerExtern,
                                           EinwohnerArbeiterExtern => True)
        - 1
        <= StadtKonstanten.LeerEinwohner
      then
         StadtEntfernenLogik.StadtEntfernen (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
         return True;
         
      else
         StadtwerteFestlegenLogik.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => False,
                                                                 StadtRasseNummerExtern   => VerteidigendeStadtRasseNummerExtern);
         MeldungenSetzenLogik.StadtmeldungSetzen (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern,
                                                  EreignisExtern         => StadtDatentypen.Einwohner_Reduktion_Enum);
         if
           LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => VerteidigendeStadtRasseNummerExtern,
                                              EinwohnerArbeiterExtern => True)
           = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, VerteidigendeStadtRasseNummerExtern.Rasse) - 1
           or
             LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => VerteidigendeStadtRasseNummerExtern,
                                                EinwohnerArbeiterExtern => True)
           = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, VerteidigendeStadtRasseNummerExtern.Rasse) - 1
         then
            StadtwerteFestlegenLogik.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
            
         else
            null;
         end if;
         
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => -1.50,
                                                  RechnenSetzenExtern      => True);
         return False;
      end if;
      
   end Kampf;
   
   
   
   function Kampfverlauf
     (AngreifendeEinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord;
      VerteidigendeStadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
   is begin
      
      GesundheitStadt := Positive (LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => VerteidigendeStadtRasseNummerExtern,
                                                                      EinwohnerArbeiterExtern => True));
      
      IDAngreifer := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern);
      
      KampfSchleife:
      loop
         
         Kampfergebnis := KampfberechnungenLogik.Kampfberechnung (AngriffExtern      => KampfwerteAngreiferExtern.Angriff,
                                                                  VerteidigungExtern => KampfwerteVerteidigerExtern.Verteidigung);
         
         if
           Kampfergebnis < 0
         then
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                                                  LebenspunkteExtern       => EinheitenDatentypen.Lebenspunkte (Kampfergebnis),
                                                  RechnenSetzenExtern      => True);
            
         elsif
           Kampfergebnis > 0
         then
            GesundheitStadt := GesundheitStadt - Kampfergebnis;
            
         else
            null;
         end if;
         
         if
           GesundheitStadt <= 0
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => AngreifendeEinheitRasseNummerExtern.Rasse,
                                                                                                                              IDExtern    => IDAngreifer),
                                                      AddierenSetzenExtern     => True);
            return True;
            
         elsif
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern) = EinheitenKonstanten.LeerLebenspunkte
         then
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern);
            return False;

         else
            null;
         end if;
         
         Kampfergebnis := KampfberechnungenLogik.Kampfberechnung (AngriffExtern      => KampfwerteVerteidigerExtern.Angriff,
                                                                  VerteidigungExtern => KampfwerteAngreiferExtern.Verteidigung);
         
         if
           Kampfergebnis < 0
         then
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                                                  LebenspunkteExtern       => EinheitenDatentypen.Lebenspunkte (Kampfergebnis),
                                                  RechnenSetzenExtern      => True);
            
         elsif
           Kampfergebnis > 0
         then
            GesundheitStadt := GesundheitStadt - Kampfergebnis;
            
         else
            null;
         end if;
         
         if
           GesundheitStadt <= 0
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => AngreifendeEinheitRasseNummerExtern.Rasse,
                                                                                                                              IDExtern    => IDAngreifer),
                                                      AddierenSetzenExtern     => True);
            return True;
            
         elsif
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern) = EinheitenKonstanten.LeerLebenspunkte
         then
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern);
            return False;

         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampfverlauf;

end KampfsystemStadtLogik;

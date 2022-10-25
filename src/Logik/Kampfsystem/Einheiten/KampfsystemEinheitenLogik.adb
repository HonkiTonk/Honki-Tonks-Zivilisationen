pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KampfDatentypen; use KampfDatentypen;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with KampfwerteEinheitErmittelnLogik;
with EinheitenErzeugenEntfernenLogik;
with PZBEingesetztLogik;
with KampfberechnungenLogik;

package body KampfsystemEinheitenLogik is

   function KampfsystemNahkampf
     (AngreiferExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      VerteidigerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        PZBEingesetztLogik.PZBEingesetzt (EinheitRasseNummerExtern => AngreiferExtern)
      is
         when True =>
            return False;
            
         when False =>
            KampfwerteVerteidiger.Verteidigung := KampfwerteEinheitErmittelnLogik.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => VerteidigerExtern,
                                                                                                               AngreiferExtern          => False);
            KampfwerteVerteidiger.Angriff := KampfwerteEinheitErmittelnLogik.AktuellerAngriffEinheit (EinheitRasseNummerExtern => VerteidigerExtern,
                                                                                                      AngreiferExtern          => False);
      
            KampfwerteAngreifer.Verteidigung := KampfwerteEinheitErmittelnLogik.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => AngreiferExtern,
                                                                                                             AngreiferExtern          => True);
            KampfwerteAngreifer.Angriff := KampfwerteEinheitErmittelnLogik.AktuellerAngriffEinheit (EinheitRasseNummerExtern => AngreiferExtern,
                                                                                                    AngreiferExtern          => True);
      
            return Kampf (VerteidigerExtern           => VerteidigerExtern,
                          KampfwerteVerteidigerExtern => KampfwerteVerteidiger,
                          AngreiferExtern             => AngreiferExtern,
                          KampfwerteAngreiferExtern   => KampfwerteAngreifer);
      end case;
      
   end KampfsystemNahkampf;



   function Kampf
     (VerteidigerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord;
      AngreiferExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
   is begin
      
      IDAngreifer := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => AngreiferExtern);
      IDVerteidiger := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => VerteidigerExtern);
            
      KampfSchleife:
      loop
         
         Kampfergebnis := KampfberechnungenLogik.Kampfberechnung (AngriffExtern      => KampfwerteAngreiferExtern.Angriff,
                                                                  VerteidigungExtern => KampfwerteVerteidigerExtern.Verteidigung);
         
         if
           Kampfergebnis < 0
         then
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreiferExtern,
                                                  LebenspunkteExtern       => EinheitenDatentypen.Lebenspunkte (Kampfergebnis),
                                                  RechnenSetzenExtern      => True);
            
         elsif
           Kampfergebnis > 0
         then
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => VerteidigerExtern,
                                                  LebenspunkteExtern       => EinheitenDatentypen.Lebenspunkte (-Kampfergebnis),
                                                  RechnenSetzenExtern      => True);
            
         else
            null;
         end if;

         if
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => VerteidigerExtern) = EinheitenKonstanten.LeerLebenspunkte
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => AngreiferExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => AngreiferExtern.Rasse,
                                                                                                                              IDExtern    => IDAngreifer),
                                                      AddierenSetzenExtern     => True);
            
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => VerteidigerExtern);
            return True;
            
         elsif
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreiferExtern) = EinheitenKonstanten.LeerLebenspunkte
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => VerteidigerExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => VerteidigerExtern.Rasse,
                                                                                                                              IDExtern    => IDVerteidiger),
                                                      AddierenSetzenExtern     => True);
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => AngreiferExtern);
            return False;
            
         else
            null;
         end if;
         
         Kampfergebnis := KampfberechnungenLogik.Kampfberechnung (AngriffExtern      => KampfwerteVerteidigerExtern.Angriff,
                                                                  VerteidigungExtern => KampfwerteAngreiferExtern.Verteidigung);
         
         if
           Kampfergebnis < 0
         then
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => VerteidigerExtern,
                                                  LebenspunkteExtern       => EinheitenDatentypen.Lebenspunkte (Kampfergebnis),
                                                  RechnenSetzenExtern      => True);
            
         elsif
           Kampfergebnis > 0
         then
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreiferExtern,
                                                  LebenspunkteExtern       => EinheitenDatentypen.Lebenspunkte (-Kampfergebnis),
                                                  RechnenSetzenExtern      => True);
            
         else
            null;
         end if;
         
         if
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => VerteidigerExtern) = EinheitenKonstanten.LeerLebenspunkte
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => AngreiferExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => AngreiferExtern.Rasse,
                                                                                                                              IDExtern    => IDAngreifer),
                                                      AddierenSetzenExtern     => True);
            
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => VerteidigerExtern);
            return True;
            
         elsif
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreiferExtern) = EinheitenKonstanten.LeerLebenspunkte
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => VerteidigerExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => VerteidigerExtern.Rasse,
                                                                                                                              IDExtern    => IDVerteidiger),
                                                      AddierenSetzenExtern     => True);
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => AngreiferExtern);
            return False;
            
         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampf;

end KampfsystemEinheitenLogik;

with KampfDatentypen;
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
   is
      use type KampfDatentypen.KampfwerteGroß;
   begin
      
      case
        PZBEingesetztLogik.PZBEingesetzt (EinheitRasseNummerExtern => AngreiferExtern)
      is
         when True =>
            return False;
            
         when False =>
            KampfwerteVerteidiger.Verteidigung := KampfwerteEinheitErmittelnLogik.Gesamtverteidigung (EinheitRasseNummerExtern => VerteidigerExtern);
            KampfwerteVerteidiger.Angriff := KampfwerteEinheitErmittelnLogik.Gesamtangriff (EinheitRasseNummerExtern => VerteidigerExtern);
      
            KampfwerteAngreifer.Verteidigung := KampfwerteEinheitErmittelnLogik.Gesamtverteidigung (EinheitRasseNummerExtern => AngreiferExtern);
            KampfwerteAngreifer.Angriff := KampfwerteEinheitErmittelnLogik.Gesamtangriff (EinheitRasseNummerExtern => AngreiferExtern);
      end case;
      
      if
        KampfwerteVerteidiger.Verteidigung = EinheitenKonstanten.LeerVerteidigung
        and
          KampfwerteVerteidiger.Angriff = EinheitenKonstanten.LeerAngriff
          and
            KampfwerteAngreifer.Verteidigung = EinheitenKonstanten.LeerVerteidigung
            and
              KampfwerteAngreifer.Angriff = EinheitenKonstanten.LeerAngriff
      then
         KampfwerteVerteidiger := (1, 1);
         KampfwerteAngreifer := (1, 1);
         
      else
         null;
      end if;
      
      return Kampf (VerteidigerExtern           => VerteidigerExtern,
                    KampfwerteVerteidigerExtern => KampfwerteVerteidiger,
                    AngreiferExtern             => AngreiferExtern,
                    KampfwerteAngreiferExtern   => KampfwerteAngreifer);
      
   end KampfsystemNahkampf;



   function Kampf
     (VerteidigerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord;
      AngreiferExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
   is
      use type EinheitenDatentypen.Lebenspunkte;
   begin
      
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
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => VerteidigerExtern) <= EinheitenKonstanten.LeerLebenspunkte
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => AngreiferExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => AngreiferExtern.Rasse,
                                                                                                                              IDExtern    => IDAngreifer),
                                                      AddierenSetzenExtern     => True);
            
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => VerteidigerExtern);
            return True;
            
         elsif
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreiferExtern) <= EinheitenKonstanten.LeerLebenspunkte
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
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => VerteidigerExtern) <= EinheitenKonstanten.LeerLebenspunkte
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => AngreiferExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => AngreiferExtern.Rasse,
                                                                                                                              IDExtern    => IDAngreifer),
                                                      AddierenSetzenExtern     => True);
            
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => VerteidigerExtern);
            return True;
            
         elsif
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreiferExtern) <= EinheitenKonstanten.LeerLebenspunkte
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

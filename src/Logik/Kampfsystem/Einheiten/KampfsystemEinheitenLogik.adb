with KampfDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with KampfwerteEinheitErmittelnLogik;
with EinheitenErzeugenEntfernenLogik;
with PZBEingesetztLogik;
with KampfberechnungenLogik;

package body KampfsystemEinheitenLogik is

   function KampfsystemNahkampf
     (AngreiferExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      VerteidigerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KampfDatentypen.KampfwerteGroß;
   begin
      
      case
        PZBEingesetztLogik.PZBEingesetzt (EinheitSpeziesNummerExtern => AngreiferExtern)
      is
         when True =>
            return False;
            
         when False =>
            KampfwerteVerteidiger.Verteidigung := KampfwerteEinheitErmittelnLogik.Gesamtverteidigung (EinheitSpeziesNummerExtern => VerteidigerExtern);
            KampfwerteVerteidiger.Angriff := KampfwerteEinheitErmittelnLogik.Gesamtangriff (EinheitSpeziesNummerExtern => VerteidigerExtern);
      
            KampfwerteAngreifer.Verteidigung := KampfwerteEinheitErmittelnLogik.Gesamtverteidigung (EinheitSpeziesNummerExtern => AngreiferExtern);
            KampfwerteAngreifer.Angriff := KampfwerteEinheitErmittelnLogik.Gesamtangriff (EinheitSpeziesNummerExtern => AngreiferExtern);
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
     (VerteidigerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord;
      AngreiferExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
   is
      use type EinheitenDatentypen.Lebenspunkte;
   begin
      
      IDAngreifer := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => AngreiferExtern);
      IDVerteidiger := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => VerteidigerExtern);
            
      KampfSchleife:
      loop
         
         Kampfergebnis := KampfberechnungenLogik.Kampfberechnung (AngriffExtern      => KampfwerteAngreiferExtern.Angriff,
                                                                  VerteidigungExtern => KampfwerteVerteidigerExtern.Verteidigung);
         
         if
           Kampfergebnis < 0
         then
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => AngreiferExtern,
                                                  LebenspunkteExtern       => EinheitenDatentypen.Lebenspunkte (Kampfergebnis),
                                                  RechnenSetzenExtern      => True);
            
         elsif
           Kampfergebnis > 0
         then
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => VerteidigerExtern,
                                                  LebenspunkteExtern       => EinheitenDatentypen.Lebenspunkte (-Kampfergebnis),
                                                  RechnenSetzenExtern      => True);
            
         else
            null;
         end if;

         if
           LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => VerteidigerExtern) <= EinheitenKonstanten.LeerLebenspunkte
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitSpeziesNummerExtern => AngreiferExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (SpeziesExtern => AngreiferExtern.Spezies,
                                                                                                                              IDExtern    => IDAngreifer),
                                                      AddierenSetzenExtern     => True);
            
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitSpeziesNummerExtern => VerteidigerExtern);
            return True;
            
         elsif
           LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => AngreiferExtern) <= EinheitenKonstanten.LeerLebenspunkte
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitSpeziesNummerExtern => VerteidigerExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (SpeziesExtern => VerteidigerExtern.Spezies,
                                                                                                                              IDExtern    => IDVerteidiger),
                                                      AddierenSetzenExtern     => True);
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitSpeziesNummerExtern => AngreiferExtern);
            return False;
            
         else
            null;
         end if;
         
         Kampfergebnis := KampfberechnungenLogik.Kampfberechnung (AngriffExtern      => KampfwerteVerteidigerExtern.Angriff,
                                                                  VerteidigungExtern => KampfwerteAngreiferExtern.Verteidigung);
         
         if
           Kampfergebnis < 0
         then
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => VerteidigerExtern,
                                                  LebenspunkteExtern       => EinheitenDatentypen.Lebenspunkte (Kampfergebnis),
                                                  RechnenSetzenExtern      => True);
            
         elsif
           Kampfergebnis > 0
         then
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => AngreiferExtern,
                                                  LebenspunkteExtern       => EinheitenDatentypen.Lebenspunkte (-Kampfergebnis),
                                                  RechnenSetzenExtern      => True);
            
         else
            null;
         end if;
         
         if
           LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => VerteidigerExtern) <= EinheitenKonstanten.LeerLebenspunkte
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitSpeziesNummerExtern => AngreiferExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (SpeziesExtern => AngreiferExtern.Spezies,
                                                                                                                              IDExtern    => IDAngreifer),
                                                      AddierenSetzenExtern     => True);
            
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitSpeziesNummerExtern => VerteidigerExtern);
            return True;
            
         elsif
           LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => AngreiferExtern) <= EinheitenKonstanten.LeerLebenspunkte
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitSpeziesNummerExtern => VerteidigerExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (SpeziesExtern => VerteidigerExtern.Spezies,
                                                                                                                              IDExtern    => IDVerteidiger),
                                                      AddierenSetzenExtern     => True);
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitSpeziesNummerExtern => AngreiferExtern);
            return False;
            
         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampf;

end KampfsystemEinheitenLogik;

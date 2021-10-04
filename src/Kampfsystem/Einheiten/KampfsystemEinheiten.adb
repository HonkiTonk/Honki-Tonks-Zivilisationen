pragma SPARK_Mode (On);

with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut, LeseEinheitenDatenbank;

with ZufallGeneratorenKampf, KampfwerteEinheitErmitteln, EinheitenErzeugenEntfernen;

package body KampfsystemEinheiten is

   function KampfsystemNahkampf
     (AngreiferExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      VerteidigerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin

      KampfwerteVerteidiger.Verteidigung := KampfwerteEinheitErmitteln.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => VerteidigerExtern,
                                                                                                    AngreiferExtern          => False);
      KampfwerteVerteidiger.Angriff := KampfwerteEinheitErmitteln.AktuellerAngriffEinheit (EinheitRasseNummerExtern => VerteidigerExtern,
                                                                                           AngreiferExtern          => False);
      
      KampfwerteAngreifer.Verteidigung := KampfwerteEinheitErmitteln.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => AngreiferExtern,
                                                                                                  AngreiferExtern          => True);
      KampfwerteAngreifer.Angriff := KampfwerteEinheitErmitteln.AktuellerAngriffEinheit (EinheitRasseNummerExtern => AngreiferExtern,
                                                                                         AngreiferExtern          => True);
      
      return Kampf (VerteidigerExtern => VerteidigerExtern,
                    AngreiferExtern   => AngreiferExtern);
      
   end KampfsystemNahkampf;



   function Kampf
     (VerteidigerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AngreiferExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
            
      KampfSchleife:
      loop

         KampfBerechnung (VerteidigerExtern  => VerteidigerExtern,
                          AngriffExtern      => KampfwerteAngreifer.Angriff,
                          VerteidigungExtern => KampfwerteVerteidiger.Verteidigung);

         if
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => VerteidigerExtern) = EinheitenKonstanten.LeerEinheit.Lebenspunkte
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => AngreiferExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => AngreiferExtern.Rasse,
                                                                                                                              IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => AngreiferExtern)),
                                                      AddierenSetzenExtern     => True);
            EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => VerteidigerExtern);
            return True;
            
         else
            null;
         end if;
         
         KampfBerechnung (VerteidigerExtern  => AngreiferExtern,
                          AngriffExtern      => KampfwerteVerteidiger.Angriff,
                          VerteidigungExtern => KampfwerteAngreifer.Verteidigung);
         
         if
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreiferExtern) = EinheitenKonstanten.LeerEinheit.Lebenspunkte
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => VerteidigerExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => VerteidigerExtern.Rasse,
                                                                                                                              IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => VerteidigerExtern)),
                                                      AddierenSetzenExtern     => True);
            EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => AngreiferExtern);
            return False;

         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampf;
   


   procedure KampfBerechnung
     (VerteidigerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AngriffExtern : in EinheitStadtDatentypen.ProduktionFeld;
      VerteidigungExtern : in EinheitStadtDatentypen.ProduktionFeld)
   is begin
      
      -- Bei Extremfällen AngerichteterSchaden schon vorher einen Wert geben?
      if
        AngriffExtern > 2 * VerteidigungExtern
      then
         WelcherFall := Extrem_Stärker;

      elsif
        AngriffExtern > VerteidigungExtern
      then
         WelcherFall := Stärker;

      elsif
        AngriffExtern < VerteidigungExtern
        and
          2 * AngriffExtern > VerteidigungExtern
      then
         WelcherFall := Schwächer;
         
      elsif
        2 * AngriffExtern < VerteidigungExtern
      then
         WelcherFall := Extrem_Schwächer;

      else
         WelcherFall := Gleich;
      end if;
      
      Kampfglück := ZufallGeneratorenKampf.KampfErfolg;
      AngerichteterSchaden := 0;
      
      AngerichteterSchadenSchleife:
      for AngerichteterSchadenSchleifenwert in reverse SchadenAngerichtetArray'Range (2) loop
         
         if
           Kampfglück >= SchadenAngerichtet (WelcherFall, AngerichteterSchadenSchleifenwert)
         then
            AngerichteterSchaden := AngerichteterSchaden + AngerichteterSchadenSchleifenwert;
            exit AngerichteterSchadenSchleife;
            
         else
            null;
         end if;
              
      end loop AngerichteterSchadenSchleife;
      
      SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => VerteidigerExtern,
                                            LebenspunkteExtern       => AngerichteterSchaden,
                                            RechnenSetzenExtern      => -1);
      
   end KampfBerechnung;

end KampfsystemEinheiten;

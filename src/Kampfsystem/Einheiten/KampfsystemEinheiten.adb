pragma SPARK_Mode (On);

with GlobaleKonstanten;
  
with ZufallGeneratorenKampf, EinheitenAllgemein, KampfwerteEinheitErmitteln, LeseEinheitenGebaut, SchreibeEinheitenGebaut;

package body KampfsystemEinheiten is

   function KampfsystemNahkampf
     (AngreiferExtern, VerteidigerExtern : in GlobaleRecords.RassePlatznummerRecord)
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
     (VerteidigerExtern, AngreiferExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
            
      KampfSchleife:
      loop

         KampfBerechnung (VerteidigerExtern  => VerteidigerExtern,
                          AngriffExtern      => KampfwerteAngreifer.Angriff,
                          VerteidigungExtern => KampfwerteVerteidiger.Verteidigung);

         if
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => VerteidigerExtern) = GlobaleKonstanten.LeerEinheit.Lebenspunkte
         then
            EinheitenAllgemein.Beförderung (EinheitRasseNummerExtern => AngreiferExtern);
            EinheitenAllgemein.EinheitEntfernen (EinheitRasseNummerExtern => VerteidigerExtern);
            return True;
            
         else
            null;
         end if;
         
         KampfBerechnung (VerteidigerExtern  => AngreiferExtern,
                          AngriffExtern      => KampfwerteVerteidiger.Angriff,
                          VerteidigungExtern => KampfwerteAngreifer.Verteidigung);
         
         if
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreiferExtern) = GlobaleKonstanten.LeerEinheit.Lebenspunkte
         then
            EinheitenAllgemein.Beförderung (EinheitRasseNummerExtern => VerteidigerExtern);
            EinheitenAllgemein.EinheitEntfernen (EinheitRasseNummerExtern => AngreiferExtern);
            return False;

         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampf;
   


   procedure KampfBerechnung
     (VerteidigerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AngriffExtern, VerteidigungExtern : in GlobaleDatentypen.ProduktionFeld)
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

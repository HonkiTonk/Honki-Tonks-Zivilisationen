pragma SPARK_Mode (On);

with GlobaleKonstanten;

with StadtEntfernen, KampfwerteStadtErmitteln, KampfwerteEinheitErmitteln, EinheitenAllgemein, KampfsystemEinheiten, ZufallGeneratorenKampf, StadtWerteFestlegen, StadtMeldungenSetzen, LeseEinheitenGebaut;

package body KampfsystemStadt is

   function KampfsystemStadt
     (AngreifendeEinheitRasseNummerExtern, VerteidigendeStadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      KampfwerteVerteidiger.Verteidigung := KampfwerteStadtErmitteln.AktuelleVerteidigungStadt (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
      KampfwerteVerteidiger.Angriff := KampfwerteStadtErmitteln.AktuellerAngriffStadt (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
      
      KampfwerteAngreifer.Verteidigung := KampfwerteEinheitErmitteln.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                                                                                                  AngreiferExtern          => True);
      KampfwerteAngreifer.Angriff := KampfwerteEinheitErmitteln.AktuellerAngriffEinheit (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                                                                                         AngreiferExtern          => True);
      
      -- Arbeiter nur halb anrechnen?
      GesundheitStadt := GlobaleVariablen.StadtGebaut (VerteidigendeStadtRasseNummerExtern.Rasse, VerteidigendeStadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1);
      
      case
        Kampfverlauf (AngreifendeEinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      if
        GlobaleVariablen.StadtGebaut (VerteidigendeStadtRasseNummerExtern.Rasse, VerteidigendeStadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) - 1 <= GlobaleKonstanten.LeerStadt.EinwohnerArbeiter (1)
      then
         StadtEntfernen.StadtEntfernen (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
         return True;
         
      else
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => False,
                                                            StadtRasseNummerExtern   => VerteidigendeStadtRasseNummerExtern);
         StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern,
                                                          EreignisExtern         => GlobaleDatentypen.Einwohner_Reduktion);
         if
           GlobaleVariablen.StadtGebaut (VerteidigendeStadtRasseNummerExtern.Rasse, VerteidigendeStadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
           = GlobaleKonstanten.StadtUmgebungWachstum (GlobaleDatentypen.Anfangswert, VerteidigendeStadtRasseNummerExtern.Rasse) - 1
           or
             GlobaleVariablen.StadtGebaut (VerteidigendeStadtRasseNummerExtern.Rasse, VerteidigendeStadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
           = GlobaleKonstanten.StadtUmgebungWachstum (GlobaleDatentypen.Endwert, VerteidigendeStadtRasseNummerExtern.Rasse) - 1
         then
            StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
            
         else
            null;
         end if;
         
         if
           LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern) - 1.50 < 0.00
         then
            GlobaleVariablen.EinheitenGebaut (AngreifendeEinheitRasseNummerExtern.Rasse, AngreifendeEinheitRasseNummerExtern.Platznummer).Bewegungspunkte := 0.00;
            
         else
            GlobaleVariablen.EinheitenGebaut (AngreifendeEinheitRasseNummerExtern.Rasse, AngreifendeEinheitRasseNummerExtern.Platznummer).Bewegungspunkte
              := GlobaleVariablen.EinheitenGebaut (AngreifendeEinheitRasseNummerExtern.Rasse, AngreifendeEinheitRasseNummerExtern.Platznummer).Bewegungspunkte - 1.50;
         end if;
         return False;
         
      end if;
      
   end KampfsystemStadt;
   
   
   
   function Kampfverlauf
     (AngreifendeEinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      KampfSchleife:
      loop
         
         SchadenStadtBerechnen (AngriffExtern      => KampfwerteAngreifer.Angriff,
                                VerteidigungExtern => KampfwerteVerteidiger.Verteidigung);

         if
           GesundheitStadt <= 0
         then
            EinheitenAllgemein.Beförderung (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern);
            return True;
            
         else
            null;
         end if;
         
         KampfsystemEinheiten.KampfBerechnung (VerteidigerExtern  => AngreifendeEinheitRasseNummerExtern,
                                               AngriffExtern      => KampfwerteVerteidiger.Angriff,
                                               VerteidigungExtern => KampfwerteAngreifer.Verteidigung);
         
         if
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern) = GlobaleKonstanten.LeerEinheit.Lebenspunkte
         then
            EinheitenAllgemein.EinheitEntfernen (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern);
            return False;

         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampfverlauf;
   
   
   
   procedure SchadenStadtBerechnen
     (AngriffExtern, VerteidigungExtern : in GlobaleDatentypen.ProduktionFeld)
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
      
      if
        GesundheitStadt - AngerichteterSchaden < GlobaleDatentypen.ProduktionFeld'First
      then
         GesundheitStadt := 0;
         
      else
         GesundheitStadt
           := GesundheitStadt - AngerichteterSchaden;
      end if;
      
   end SchadenStadtBerechnen;

end KampfsystemStadt;

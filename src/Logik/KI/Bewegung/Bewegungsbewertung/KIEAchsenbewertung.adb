with KartenartDatentypen;

with LeseWeltkarteneinstellungen;

package body KIEAchsenbewertung is

   function EAchseBewerten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      AktuelleEbeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.KartenfeldNatural
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      if
        NeueEbeneExtern = ZielebeneExtern
      then
         return 0;
         
      else
         AnzahlFelder := abs (Ebenenumrechnung (ZielebeneExtern) - Ebenenumrechnung (AktuelleEbeneExtern));
         Felder (1) := abs (Ebenenumrechnung (ZielebeneExtern) - Ebenenumrechnung (NeueEbeneExtern));
      end if;
      
      case
        LeseWeltkarteneinstellungen.EAchseOben
      is
         when KartenartDatentypen.Karte_E_Kein_Übergang_Enum =>
            Felder (2) := KartenDatentypen.KartenfeldPositiv'Last;
            
         when KartenartDatentypen.Karte_E_Übergang_Enum =>
            Felder (2) := StandardübergangOben (ZielebeneExtern     => ZielebeneExtern,
                                                       AktuelleEbeneExtern => AktuelleEbeneExtern,
                                                       NeueEbeneExtern     => NeueEbeneExtern);
      end case;
      
      case
        LeseWeltkarteneinstellungen.EAchseUnten
      is
         when KartenartDatentypen.Karte_E_Kein_Übergang_Enum =>
            Felder (3) := KartenDatentypen.KartenfeldPositiv'Last;
            
         when KartenartDatentypen.Karte_E_Übergang_Enum =>
            Felder (3) := StandardübergangUnten (ZielebeneExtern     => ZielebeneExtern,
                                                  AktuelleEbeneExtern => AktuelleEbeneExtern,
                                                  NeueEbeneExtern     => NeueEbeneExtern);
      end case;
      
      WelcheFelderanzahl := 0;
      
      BewertenSchleife:
      for BewertenSchleifenwert in FelderArray'Range loop
         
         if
           Felder (BewertenSchleifenwert) < AnzahlFelder
           and
             WelcheFelderanzahl = 0
         then
            WelcheFelderanzahl := BewertenSchleifenwert;
            
         elsif
           WelcheFelderanzahl /= 0
           and then
             Felder (BewertenSchleifenwert) < Felder (WelcheFelderanzahl)
         then
            WelcheFelderanzahl := BewertenSchleifenwert;
            
         else
            null;
         end if;
                    
      end loop BewertenSchleife;
      
      case
        WelcheFelderanzahl
      is
         when 0 =>
            return AnzahlFelder;
            
         when others =>
            return Felder (WelcheFelderanzahl);
      end case;
   
   end EAchseBewerten;
   
   
   
   function StandardübergangOben
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      AktuelleEbeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.KartenfeldNatural
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      if
        Ebenenumrechnung (NeueEbeneExtern) > Ebenenumrechnung (AktuelleEbeneExtern)
        and
          Ebenenumrechnung (AktuelleEbeneExtern) > Ebenenumrechnung (ZielebeneExtern)
      then
         return Ebenenumrechnung (ZielebeneExtern) - Ebenenumrechnung (NeueEbeneExtern) + Ebenenumrechnung (KartenDatentypen.EbeneVorhanden'Last);
                  
      else
         return KartenDatentypen.KartenfeldPositiv'Last;
      end if;
      
   end StandardübergangOben;
   
   
   
   function StandardübergangUnten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      AktuelleEbeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.KartenfeldNatural
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      if
        Ebenenumrechnung (ZielebeneExtern) > Ebenenumrechnung (AktuelleEbeneExtern)
        and
          Ebenenumrechnung (AktuelleEbeneExtern) > Ebenenumrechnung (NeueEbeneExtern)
      then
         return Ebenenumrechnung (NeueEbeneExtern) - Ebenenumrechnung (ZielebeneExtern) + Ebenenumrechnung (KartenDatentypen.EbeneVorhanden'Last);
         
      else
         return KartenDatentypen.KartenfeldPositiv'Last;
      end if;
      
   end StandardübergangUnten;

end KIEAchsenbewertung;

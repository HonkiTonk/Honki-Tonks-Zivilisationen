with KartenartDatentypen;

with LeseWeltkarteneinstellungen;

package body KIEAchsenbewertung is

   function EAchseBewerten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
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
         Felderanzahl (1) := abs (Ebenenumrechnung (ZielebeneExtern) - Ebenenumrechnung (NeueEbeneExtern));
      end if;
      
      case
        LeseWeltkarteneinstellungen.EAchseOben
      is
         when KartenartDatentypen.Karte_E_Kein_Übergang_Enum =>
            Felderanzahl (2) := KartenDatentypen.KartenfeldPositiv'Last;
            
         when KartenartDatentypen.Karte_E_Übergang_Enum =>
            Felderanzahl (2) := StandardübergangOben (ZielebeneExtern => ZielebeneExtern,
                                                       NeueEbeneExtern => NeueEbeneExtern);
      end case;
      
      case
        LeseWeltkarteneinstellungen.EAchseUnten
      is
         when KartenartDatentypen.Karte_E_Kein_Übergang_Enum =>
            Felderanzahl (3) := KartenDatentypen.KartenfeldPositiv'Last;
            
         when KartenartDatentypen.Karte_E_Übergang_Enum =>
            Felderanzahl (3) := StandardübergangUnten (ZielebeneExtern => ZielebeneExtern,
                                                        NeueEbeneExtern => NeueEbeneExtern);
      end case;
      
      WelcheFelderanzahl := 1;
      
      BewertenSchleife:
      for BewertenSchleifenwert in FelderanzahlArray'Range loop
         
         if
           Felderanzahl (BewertenSchleifenwert) < Felderanzahl (WelcheFelderanzahl)
         then
            WelcheFelderanzahl := BewertenSchleifenwert;
            
         else
            null;
         end if;
                    
      end loop BewertenSchleife;
      
      return Felderanzahl (WelcheFelderanzahl);
   
   end EAchseBewerten;
   
   
   
   function StandardübergangOben
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.KartenfeldNatural
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      if
        Ebenenumrechnung (NeueEbeneExtern) > Ebenenumrechnung (ZielebeneExtern)
      then
         return Ebenenumrechnung (ZielebeneExtern) - Ebenenumrechnung (NeueEbeneExtern) + Ebenenumrechnung (KartenDatentypen.EbeneVorhanden'Last);
                  
      else
         return KartenDatentypen.KartenfeldPositiv'Last;
      end if;
      
   end StandardübergangOben;
   
   
   
   function StandardübergangUnten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.KartenfeldNatural
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      if
        Ebenenumrechnung (ZielebeneExtern) > Ebenenumrechnung (NeueEbeneExtern)
      then
         return Ebenenumrechnung (NeueEbeneExtern) - Ebenenumrechnung (ZielebeneExtern) + Ebenenumrechnung (KartenDatentypen.EbeneVorhanden'Last);
         
      else
         return KartenDatentypen.KartenfeldPositiv'Last;
      end if;
      
   end StandardübergangUnten;

end KIEAchsenbewertung;

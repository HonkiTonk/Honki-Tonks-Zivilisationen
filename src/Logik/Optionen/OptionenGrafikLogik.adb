with GrafikDatentypen;
with TextnummernKonstanten;
with MenueDatentypen;
with ZeitKonstanten;
with GrafikKonstanten;
with ZahlenDatentypen;

with SchreibeEinstellungenGrafik;
with LeseEinstellungenGrafik;

with NachGrafiktask;
with NachLogiktask;
with AuswahlaufteilungLogik;
with ZahleneingabeLogik;
with SchreibenEinstellungenLogik;
with Fehlermeldungssystem;

package body OptionenGrafikLogik is

   function OptionenGrafik
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
            
      GrafikSchleife:
      loop
         
         AuswahlWert := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Grafik_Menü_Enum);
         
         case
           AuswahlWert
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               AuflösungÄndern;
            
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               VollbildFenster;
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               BildrateÄndern;
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               SchreibeEinstellungenGrafik.EbenenUnterhalbSichtbar;
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               SchreibenEinstellungenLogik.Grafikeinstellungen;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
               
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "OptionenGrafikLogik.OptionenGrafik: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
         end case;
         
      end loop GrafikSchleife;
      
   end OptionenGrafik;
   
   
   
   procedure AuflösungÄndern
   is begin
      
      EingabeAuflösung := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZahlenDatentypen.EigenesPositive (GrafikKonstanten.MinimaleAuflösungsbreite),
                                                             ZahlenMaximumExtern => ZahlenDatentypen.EigenesPositive (GrafikKonstanten.MaximaleAuflösungsbreite),
                                                             WelcheFrageExtern   => TextnummernKonstanten.FrageAuflösungsbreite);
      
      case
        EingabeAuflösung.ErfolgreichAbbruch
      is
         when False =>
            return;
            
         when True =>
            NeueAuflösung.x := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
      
            EingabeAuflösung := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZahlenDatentypen.EigenesPositive (GrafikKonstanten.MinimaleAuflösunghöhe),
                                                                   ZahlenMaximumExtern => ZahlenDatentypen.EigenesPositive (GrafikKonstanten.MaximaleAuflösungshöhe),
                                                                   WelcheFrageExtern   => TextnummernKonstanten.FrageAuflösungshöhe);
      end case;
      
      case
        EingabeAuflösung.ErfolgreichAbbruch
      is
         when False =>
            return;
            
         when True =>
            NeueAuflösung.y := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
      
            SchreibeEinstellungenGrafik.Auflösung (AuflösungExtern => NeueAuflösung);
      
            NachLogiktask.GrafikWarten := True;
            NachGrafiktask.FensterVerändert := GrafikDatentypen.Auflösung_Verändert_Enum;
      end case;
      
      ErzeugungNeuesFensterAbwartenSchleife:
      while NachLogiktask.GrafikWarten loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop ErzeugungNeuesFensterAbwartenSchleife;
            
   end AuflösungÄndern;
   
   
   
   procedure BildrateÄndern
   is
      use type GrafikDatentypen.Fenster_Ändern_Enum;
   begin
      
      EingabeBildrate := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZahlenDatentypen.EigenesPositive (GrafikKonstanten.MinimaleBildrate),
                                                           ZahlenMaximumExtern => ZahlenDatentypen.EigenesPositive (GrafikKonstanten.MaximaleBildrate),
                                                           WelcheFrageExtern   => TextnummernKonstanten.FrageBildrate);
      
      case
        EingabeBildrate.ErfolgreichAbbruch
      is
         when False =>
            return;
            
         when True =>
            SchreibeEinstellungenGrafik.Bildrate (BildrateExtern => Sf.sfUint32 (EingabeBildrate.EingegebeneZahl));
            NachGrafiktask.FensterVerändert := GrafikDatentypen.Bildrate_Ändern_Enum;
      end case;
      
      NeueBildrateAbwartenSchleife:
      while NachGrafiktask.FensterVerändert = GrafikDatentypen.Bildrate_Ändern_Enum loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop NeueBildrateAbwartenSchleife;
      
   end BildrateÄndern;
   
   
   
   procedure VollbildFenster
   is
      use type GrafikDatentypen.Fenster_Ändern_Enum;
   begin
      
      -- Wenn ich weitere Fenstermodis einbauen will muss ich das hier umbauen. äöü
      case
        LeseEinstellungenGrafik.Fenstermodus
      is
         when GrafikKonstanten.StandardFenster =>
            SchreibeEinstellungenGrafik.Fenstermodus (FenstermodusExtern => GrafikKonstanten.Vollbild);
            
         when GrafikKonstanten.Vollbild =>
            SchreibeEinstellungenGrafik.Fenstermodus (FenstermodusExtern => GrafikKonstanten.StandardFenster);
            
         when others =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "OptionenGrafikLogik.VollbildFenster: Unbekannter Fenstermodus: " & LeseEinstellungenGrafik.Fenstermodus'Wide_Wide_Image);
            SchreibeEinstellungenGrafik.Fenstermodus (FenstermodusExtern => GrafikKonstanten.StandardFenster);
      end case;
      
      NachGrafiktask.FensterVerändert := GrafikDatentypen.Modus_Verändert_Enum;
      
      ErzeugungNeuesFensterAbwartenSchleife:
      while NachGrafiktask.FensterVerändert = GrafikDatentypen.Modus_Verändert_Enum loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop ErzeugungNeuesFensterAbwartenSchleife;
      
   end VollbildFenster;

end OptionenGrafikLogik;

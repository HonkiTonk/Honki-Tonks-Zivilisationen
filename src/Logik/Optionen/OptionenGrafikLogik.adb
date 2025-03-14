with TextKonstantenHTSEB;

with GrafikDatentypen;
with TextnummernKonstanten;
with MenueDatentypen;
with ZeitKonstanten;
with GrafikKonstanten;
with ZahlenDatentypen;
with VerzeichnisKonstanten;

with SchreibeEinstellungenGrafik;
with LeseEinstellungenGrafik;
with SchreibeLogiktask;
with LeseLogiktask;
with SchreibeGrafiktask;
with LeseGrafiktask;
with SchreibeOptionen;

with AuswahlaufteilungLogik;
with ZahleneingabeLogik;
with MeldungssystemHTSEB;
with SchreibenEinstellungenLogik;
with EinlesenTexturenLogik;
with SetauswahlLogik;
with EinlesenSetsLogik;

package body OptionenGrafikLogik is

   function OptionenGrafik
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is
      use type Sf.sfBool;
   begin
      
      EinstellungenSchreiben := False;
      EinstellungenGeändert := False;
            
      GrafikSchleife:
      loop
         
         AuswahlWert := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Grafik_Menü_Enum);
         
         case
           AuswahlWert
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               EinstellungenGeändert := AuflösungÄndern;
            
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               VollbildFenster;
               EinstellungenGeändert := True;
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               SchreibeEinstellungenGrafik.VSync (AktivierenDeaktivierenExtern => not LeseEinstellungenGrafik.VSync);
               SchreibeGrafiktask.FensterAnpassen (AnpassungExtern => GrafikDatentypen.Bildrate_Ändern_Enum);
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               EinstellungenGeändert := BildrateÄndern;
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               SchreibeEinstellungenGrafik.EbenenUnterhalbSichtbar;
               EinstellungenGeändert := True;
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               SchreibeEinstellungenGrafik.BildrateAnzeigen;
               EinstellungenGeändert := True;
               
            when RueckgabeDatentypen.Auswahl_Sieben_Enum =>
               EinstellungenGeändert := TexturenWechseln;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               exit GrafikSchleife;
               
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "OptionenGrafikLogik.OptionenGrafik: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
         end case;
         
         case
           EinstellungenGeändert
         is
            when True =>
               EinstellungenSchreiben := True;
               
            when False =>
               null;
         end case;
         
      end loop GrafikSchleife;
      
      case
        EinstellungenSchreiben
      is
         when True =>
            SchreibenEinstellungenLogik.Grafikeinstellungen;
            
         when False =>
            null;
      end case;
      
      return AuswahlWert;
      
   end OptionenGrafik;
   
   
   
   function AuflösungÄndern
     return Boolean
   is begin
      
      EingabeAuflösung := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZahlenDatentypen.EigenesPositive (GrafikKonstanten.MinimaleAuflösungsbreite),
                                                             ZahlenMaximumExtern => ZahlenDatentypen.EigenesPositive (GrafikKonstanten.MaximaleAuflösungsbreite),
                                                             WelcheFrageExtern   => TextnummernKonstanten.FrageAuflösungsbreite);
      
      case
        EingabeAuflösung.ErfolgreichAbbruch
      is
         when False =>
            return False;
            
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
            return False;
            
         when True =>
            NeueAuflösung.y := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
      
            SchreibeEinstellungenGrafik.Auflösung (AuflösungExtern => NeueAuflösung);
      
            SchreibeLogiktask.WartenGrafik (ZustandExtern => True);
            SchreibeGrafiktask.FensterAnpassen (AnpassungExtern => GrafikDatentypen.Auflösung_Verändert_Enum);
      end case;
      
      ErzeugungNeuesFensterAbwartenSchleife:
      while LeseLogiktask.WartenGrafik = True loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop ErzeugungNeuesFensterAbwartenSchleife;
      
      return True;
            
   end AuflösungÄndern;
   
   
   
   function BildrateÄndern
     return Boolean
   is
      use type GrafikDatentypen.Fenster_Anpassen_Enum;
   begin
      
      EingabeBildrate := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZahlenDatentypen.EigenesNatural (GrafikKonstanten.MinimaleBildrate),
                                                           ZahlenMaximumExtern => ZahlenDatentypen.EigenesPositive (GrafikKonstanten.MaximaleBildrate),
                                                           WelcheFrageExtern   => TextnummernKonstanten.FrageBildrate);
      
      case
        EingabeBildrate.ErfolgreichAbbruch
      is
         when False =>
            return False;
            
         when True =>
            SchreibeEinstellungenGrafik.Bildrate (BildrateExtern => Sf.sfUint32 (EingabeBildrate.EingegebeneZahl));
            SchreibeEinstellungenGrafik.VSync (AktivierenDeaktivierenExtern => Sf.sfFalse);
            SchreibeGrafiktask.FensterAnpassen (AnpassungExtern => GrafikDatentypen.Bildrate_Ändern_Enum);
      end case;
      
      NeueBildrateAbwartenSchleife:
      while LeseGrafiktask.FensterAnpassen = GrafikDatentypen.Bildrate_Ändern_Enum loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop NeueBildrateAbwartenSchleife;
      
      return True;
      
   end BildrateÄndern;
   
   
   
   procedure VollbildFenster
   is
      use type GrafikDatentypen.Fenster_Anpassen_Enum;
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
            MeldungssystemHTSEB.Logik (MeldungExtern => "OptionenGrafikLogik.VollbildFenster: Unbekannter Fenstermodus: " & LeseEinstellungenGrafik.Fenstermodus'Wide_Wide_Image);
            SchreibeEinstellungenGrafik.Fenstermodus (FenstermodusExtern => GrafikKonstanten.StandardFenster);
      end case;
      
      SchreibeGrafiktask.FensterAnpassen (AnpassungExtern => GrafikDatentypen.Modus_Verändert_Enum);
      
      ErzeugungNeuesFensterAbwartenSchleife:
      while LeseGrafiktask.FensterAnpassen = GrafikDatentypen.Modus_Verändert_Enum loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop ErzeugungNeuesFensterAbwartenSchleife;
      
   end VollbildFenster;
   
   
   
   function TexturenWechseln
     return Boolean
   is begin
      
      case
        EinlesenSetsLogik.EinlesenSets (OrdnerExtern => VerzeichnisKonstanten.GrafikOhneStrich)
      is
         when True =>
            GewählteTexturen := SetauswahlLogik.Setauswahl (SpracheExtern => False);
            
            if
              GewählteTexturen = TextKonstantenHTSEB.LeerUnboundedString
            then
               null;
               
            else
               -- Das hier als Funktion aufrufen um bei Fehlern nicht den falschen Wert zu schreiben? äöü
               SchreibeOptionen.Texturen (TexturenExtern => GewählteTexturen);
               EinlesenTexturenLogik.EinlesenTexturen;
               return True;
            end if;
            
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "OptionenGrafikLogik.TexturenWechseln: Texturen nicht gefunden.");
      end case;
      
      return False;
        
   end TexturenWechseln;

end OptionenGrafikLogik;

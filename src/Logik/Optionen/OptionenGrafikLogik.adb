pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen; use GrafikDatentypen;
with TextnummernKonstanten;
with ZahlenDatentypen;
with MenueDatentypen;

with NachGrafiktask;
with NachLogiktask;
with AuswahlaufteilungLogik;
with ZahleneingabeLogik;
with EinstellungenGrafik;
with SchreibenEinstellungenLogik;
with Fehler;

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
               EinstellungenGrafik.Grafikeinstellungen.EbeneUnterhalbSichtbar := not EinstellungenGrafik.Grafikeinstellungen.EbeneUnterhalbSichtbar;
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               SchreibenEinstellungenLogik.Grafikeinstellungen;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenGrafik.OptionenGrafik: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
         end case;
         
      end loop GrafikSchleife;
      
   end OptionenGrafik;
   
   
   
   procedure AuflösungÄndern
   is begin
      
      EingabeAuflösung := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 320,
                                                             ZahlenMaximumExtern => ZahlenDatentypen.EigenerInteger'Last,
                                                             WelcheFrageExtern   => TextnummernKonstanten.FrageAuflösungsbreite);
      
      if
        EingabeAuflösung.ErfolgreichAbbruch
      then
         NeueAuflösung.x := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
           
      else
         return;
      end if;
      
      EingabeAuflösung := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 240,
                                                             ZahlenMaximumExtern => ZahlenDatentypen.EigenerInteger'Last,
                                                             WelcheFrageExtern   => TextnummernKonstanten.FrageAuflösungshöhe);
      
      if
        EingabeAuflösung.ErfolgreichAbbruch
      then
         NeueAuflösung.y := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
           
      else
         NeueAuflösung.x := 0;
         return;
      end if;
      
      EinstellungenGrafik.FensterEinstellungen.FensterBreite := NeueAuflösung.x;
      EinstellungenGrafik.FensterEinstellungen.FensterHöhe := NeueAuflösung.y;
      
      NachLogiktask.Warten := True;
      NachGrafiktask.FensterVerändert := GrafikDatentypen.Auflösung_Verändert_Enum;
      
      ErzeugungNeuesFensterAbwartenSchleife:
      while NachLogiktask.Warten loop
         
         delay 0.002;
         
      end loop ErzeugungNeuesFensterAbwartenSchleife;
            
   end AuflösungÄndern;
   
   
   
   procedure BildrateÄndern
   is begin
      
      EingabeBildrate := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 0,
                                                           ZahlenMaximumExtern => ZahlenDatentypen.EigenerInteger'Last,
                                                           WelcheFrageExtern   => TextnummernKonstanten.FrageBildrate);
      
      if
        EingabeBildrate.ErfolgreichAbbruch
      then
         return;
         
      else
         EinstellungenGrafik.FensterEinstellungen.Bildrate := Sf.sfUint32 (EingabeBildrate.EingegebeneZahl);
         NachGrafiktask.FensterVerändert := GrafikDatentypen.Bildrate_Ändern_Enum;
      end if;
            
      NeueBildrateAbwartenSchleife:
      while NachGrafiktask.FensterVerändert = GrafikDatentypen.Bildrate_Ändern_Enum loop
         
         delay 0.002;
         
      end loop NeueBildrateAbwartenSchleife;
      
   end BildrateÄndern;
   
   
   
   procedure VollbildFenster
   is begin
      
      case
        EinstellungenGrafik.FensterEinstellungen.FensterVollbild
      is
         when 7 =>
            EinstellungenGrafik.FensterEinstellungen.FensterVollbild := 8;
            
         when 8 =>
            EinstellungenGrafik.FensterEinstellungen.FensterVollbild := 7;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "OptionenGrafik.VollbildFenster: Unbekannter Fenstermodus gewählt: " & EinstellungenGrafik.FensterEinstellungen.FensterVollbild'Wide_Wide_Image);
      end case;
      
      NachGrafiktask.FensterVerändert := GrafikDatentypen.Modus_Verändert_Enum;
      
      ErzeugungNeuesFensterAbwartenSchleife:
      while NachGrafiktask.FensterVerändert = GrafikDatentypen.Modus_Verändert_Enum loop
         
         delay 0.002;
         
      end loop ErzeugungNeuesFensterAbwartenSchleife;
      
   end VollbildFenster;

end OptionenGrafikLogik;

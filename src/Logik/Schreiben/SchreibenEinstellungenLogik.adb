with SystemRecords;
with VerzeichnisKonstanten;
with GrafikRecords;
with TonRecords;
with TastenbelegungDatenbank;

with LeseOptionen;
with LeseEinstellungenSound;
with LeseEinstellungenGrafik;
with LeseEinstellungenMusik;

with TexteinstellungenGrafik;
with SpezieseinstellungenGrafik;

package body SchreibenEinstellungenLogik is
   
   procedure Nutzereinstellungen
   is begin
      
      Create (File => DateiNutzereinstellungen,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Nutzereinstellungen,
              Form => "WCEM=8");
      
      SystemRecords.NutzerEinstellungenRecord'Write (Stream (File => DateiNutzereinstellungen),
                                                     LeseOptionen.GanzerEintrag);
      
      Close (File => DateiNutzereinstellungen);
      
   end Nutzereinstellungen;
   
   
   
   procedure Grafikeinstellungen
   is begin
      
      Create (File => DateiGrafikeinstellungen,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Grafikeinstellungen,
              Form => "WCEM=8");
            
      GrafikRecords.FensterRecord'Write (Stream (File => DateiGrafikeinstellungen),
                                         LeseEinstellungenGrafik.Fenstereinstellungen);
      GrafikRecords.GrafikeinstellungenRecord'Write (Stream (File => DateiGrafikeinstellungen),
                                                     LeseEinstellungenGrafik.Grafikeinstellungen);
      
      TexteinstellungenGrafik.SchriftgrößenArray'Write (Stream (File => DateiGrafikeinstellungen),
                                                          TexteinstellungenGrafik.SchriftgrößeneintragLesen);
      TexteinstellungenGrafik.SchriftfarbenArray'Write (Stream (File => DateiGrafikeinstellungen),
                                                        TexteinstellungenGrafik.SchriftfarbeneintragLesen);
      
      SpezieseinstellungenGrafik.SpeziesFarbenArray'Write (Stream (File => DateiGrafikeinstellungen),
                                                           SpezieseinstellungenGrafik.FarbenarrayLesen);
      SpezieseinstellungenGrafik.SpeziesFarbenArray'Write (Stream (File => DateiGrafikeinstellungen),
                                                           SpezieseinstellungenGrafik.RahmenarrayLesen);
      
      Close (File => DateiGrafikeinstellungen);
      
   end Grafikeinstellungen;
   
   
   
   procedure Soundeinstellungen
   is begin
      
      Create (File => DateiSoundeinstellungen,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Toneinstellungen,
              Form => "WCEM=8");
      
      TonRecords.SoundeinstellungenRecord'Write (Stream (File => DateiSoundeinstellungen),
                                                 LeseEinstellungenSound.GanzerEintrag);
      
      TonRecords.MusikeinstellungenRecord'Write (Stream (File => DateiSoundeinstellungen),
                                                 LeseEinstellungenMusik.GanzerEintrag);
      
      Close (File => DateiSoundeinstellungen);
            
   end Soundeinstellungen;
   
   

   procedure TastenbelegungSchreiben
   is begin
      
      Create (File => DateiTastenbelegung,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Tastenbelegung,
              Form => "WCEM=8");
      
      TastenbelegungDatenbank.AllgemeineBelegungArray'Write (Stream (File => DateiTastenbelegung),
                                                             TastenbelegungDatenbank.AllgemeineBelegung);
      
      TastenbelegungDatenbank.EinheitenbelegungArray'Write (Stream (File => DateiTastenbelegung),
                                                            TastenbelegungDatenbank.Einheitenbelegung);
      
      TastenbelegungDatenbank.StadtbelegungArray'Write (Stream (File => DateiTastenbelegung),
                                                        TastenbelegungDatenbank.Stadtbelegung);
      
      Close (File => DateiTastenbelegung);
      
   end TastenbelegungSchreiben;

end SchreibenEinstellungenLogik;

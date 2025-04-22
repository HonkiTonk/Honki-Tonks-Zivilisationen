VorhandeneFeldeffekte := 0;
AktuellerFeldeffekt := 1;

FeldeffekteSchleife:
for FeldeffekteSchleifenwert in KartenRecords.FeldeffektArray'Range loop

   case
     FeldeffekteExtern (FeldeffekteSchleifenwert)
   is
      when True =>
         VorhandeneFeldeffekte := VorhandeneFeldeffekte + AktuellerFeldeffekt;

      when False =>
         null;
   end case;

   AktuellerFeldeffekt := AktuellerFeldeffekt * 2;

end loop FeldeffekteSchleife;

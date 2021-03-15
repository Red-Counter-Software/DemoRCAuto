select a.[Targa], a.[Marca]
from [dbo].[Auto] as a
where a.[Cilindrata] > 2000 OR a.[Potenza] > 120

select a.[Nome], b.[Targa]
from [dbo].[Proprietari] as a
inner join [dbo].[Auto] as b
on b.[CodiceFiscaleProprietario] = a.[CodiceFiscale]
where b.[Cilindrata] > 2000 OR b.[Potenza] > 120

select a.[Nome], b.[Targa]
from [dbo].[Proprietari] as a
inner join [dbo].[Auto] as b
on b.[CodiceFiscaleProprietario] = a.[CodiceFiscale]
inner join [dbo].[Assicurazioni] as c
on c.[Codice] = b.[CodiceAssicurazione]
where c.Nome = 'SARA' AND (b.[Cilindrata] > 2000 OR b.[Potenza] > 120)

select b.[Targa], d.[Nome]
from [dbo].[AutoCoinvolte] as a
inner join [dbo].[Auto] as b
on b.[Targa] = a.[Targa]
inner join [dbo].[Sinistri] as c
on c.[Codice] = a.[CodiceSinistro]
inner join [dbo].[Proprietari] as d
on d.[CodiceFiscale] = b.[CodiceFiscaleProprietario]
inner join [dbo].[Assicurazioni] as e
on e.[Codice] = b.[CodiceAssicurazione]
where e.[Nome] = 'SARA' AND c.[Data] = '2002-01-20'

select a.[Nome], a.[Sede], count(b.[Targa]) as [NumeroAutoAssicurate]
from [dbo].[Assicurazioni] as a
left join [dbo].[Auto] as b
on b.[CodiceAssicurazione] = a.[Codice]
group by a.[Nome], a.[Sede]

select a.[Targa], count(c.[Codice]) as [NumeroSinistri]
from [dbo].[AutoCoinvolte] as a
inner join [dbo].[Auto] as b
on b.[Targa] = a.[Targa]
left join [dbo].[Sinistri] as c
on c.[Codice] = a.[CodiceSinistro]
where b.[Marca] = 'Fiat'
group by a.[Targa]

select a.[Targa], c.[Nome], sum(a.[ImportoDelDanno]) as [ImportoTotaleDanni]
from [dbo].[AutoCoinvolte] as a
inner join [dbo].[Auto] as b
on b.[Targa] = a.[Targa]
inner join [dbo].[Assicurazioni] as c
on c.[Codice] = b.[CodiceAssicurazione]
left join [dbo].[Sinistri] as d
on d.[Codice] = a.[CodiceSinistro]
group by a.[Targa], c.[Nome]
having count(d.[Codice]) > 1

select a.[CodiceFiscale], a.[Nome]
from [dbo].[Proprietari] as a
left join [dbo].[Auto] as b
on b.[CodiceFiscaleProprietario] = a.[CodiceFiscale]
group by a.[CodiceFiscale], a.[Nome]
having count(b.[Targa]) > 1

select a.[Targa]
from [dbo].[AutoCoinvolte] as a
except
(select a.[Targa]
from [dbo].[AutoCoinvolte] as a
inner join [dbo].[Sinistri] as b
on b.[Codice] = a.[CodiceSinistro]
where b.[Data] > '2001-01-20')

select b.[Codice]
from [dbo].[AutoCoinvolte] as a
inner join [dbo].[Sinistri] as b
on b.[Codice] = a.[CodiceSinistro]
inner join dbo.[Auto] as c
on c.[Targa] = a.[Targa]
where c.[Cilindrata] > 2000